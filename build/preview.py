#!/usr/bin/env python3
"""Render assets/preview-<variant>.png from palette.toml (needs Pillow).

  python build/preview.py            # furnace, lifted, paper
  python build/preview.py all        # every variant
"""
import sys, tomllib
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent.parent
FONT_DIRS = [Path.home() / ".local/share/fonts/NerdFonts", Path("/usr/share/fonts/TTF")]
FONT = "IosevkaNerdFont-{}.ttf"
PREVIEWS = ["furnace", "lifted", "paper"]
W, H = 1000, 560


def font(style, size):
    for d in FONT_DIRS:
        f = d / FONT.format(style)
        if f.exists():
            return ImageFont.truetype(str(f), size)
    sys.exit(f"font not found: {FONT.format(style)}")


def palette(variant):
    pal = tomllib.loads((ROOT / "palette.toml").read_text())
    v = pal["variants"][variant]
    p = dict(pal["accents"])
    p.update({k: x for k, x in v.items() if isinstance(x, str)})
    p.update(v.get("accents", {}))
    return p


# (text, palette key, bold, italic, underline)
def code(p):
    R = lambda s, k, b=0, i=0, u=0: (s, p[k], b, i, u)
    return [
        [R("-- the third gate opens at dawn, see ", "incense", i=1), R("https://sect.archive/records", "furnace", i=1, u=1)],
        [R("local ", "heaven"), R("Furnace ", "text"), R("= ", "incense"), R("require", "jade", b=1), R("(", "incense"), R('"sect.alchemy"', "elixir"), R(")", "incense")],
        [R("function ", "heaven"), R("Furnace", "text"), R(".", "incense"), R("refine", "jade"), R("(", "incense"), R("herbs", "furnace", i=1), R(", ", "incense"), R("heat", "furnace", i=1), R(")", "incense")],
        [R("  ", "text"), R("local ", "heaven"), R("pill ", "text"), R("= ", "incense"), R("herbs ", "text"), R("or ", "incense"), R("9", "elixir")],
        [R("  ", "text"), R("if ", "heaven"), R("heat ", "text"), R("> ", "incense"), R("900 ", "elixir"), R("then ", "heaven"), R("return ", "heaven"), R("nil", "elixir", b=1), R(", ", "incense"), R('"ash"', "elixir"), R(" end", "heaven")],
        [R("  ", "text"), R("return ", "heaven"), R("qi", "text"), R(":", "incense"), R("condense", "furnace"), R("(", "incense"), R("pill", "text"), R(")", "incense"), R(", qi.", "incense"), R("grade", "blossom")],
        [R("end", "heaven")],
    ]


def tfvars(p):
    R = lambda s, k, b=0, i=0, u=0: (s, p[k], b, i, u)
    return [
        [R("container    ", "blossom"), R("= ", "incense"), R('"regulations-api"', "elixir")],
        [R("db_host      ", "blossom"), R("= ", "incense"), R('"regulations-postgres.int.staging"', "elixir")],
        [R("replicas     ", "blossom"), R("= ", "incense"), R("3", "elixir"), R("   ", "text"), R("# ", "incense", i=1), R("breakthrough", "tribulation"), R(" ok ", "incense", i=1), R("✓", "herb")],
    ]


def rounded(d, box, fill, r=10):
    d.rounded_rectangle(box, radius=r, fill=fill)


def draw_runs(d, x, y, runs, fonts):
    for s, fill, b, i, u in runs:
        f = fonts[(b, i)]
        d.text((x, y), s, fill=fill, font=f)
        w = f.getlength(s)
        if u:
            d.line([x, y + 20, x + w, y + 20], fill=fill, width=1)
        x += w
    return x


def render(variant):
    p = palette(variant)
    fonts = {(0, 0): font("Regular", 19), (1, 0): font("Bold", 19), (0, 1): font("Italic", 19), (1, 1): font("BoldItalic", 19)}
    title = font("Bold", 26)
    small = font("Regular", 17)
    im = Image.new("RGB", (W, H), p["base"])
    d = ImageDraw.Draw(im)

    name = f"Spirit Furnace · {variant}"
    d.text(((W - title.getlength(name)) / 2, 22), name, fill=p["text"], font=title)

    accents = ["tribulation", "elixir", "jade", "heaven", "furnace", "blossom", "core", "herb"]
    gap, x0 = 12, 40
    sw = (W - 2 * x0 - gap * (len(accents) - 1)) / len(accents)
    for i, k in enumerate(accents):
        x = x0 + i * (sw + gap)
        rounded(d, [x, 70, x + sw, 116], p[k], r=6)

    # editor panel
    top, lh = 150, 30
    lines = code(p)
    rounded(d, [36, top, W - 36, top + 24 + lh * len(lines) + 12], p["surface"])
    cur = 4
    for n, runs in enumerate(lines):
        y = top + 18 + n * lh
        if n == cur:
            d.rectangle([46, y - 4, W - 46, y + lh - 6], fill=p["overlay"])
        d.text((20, y), str(n + 1), fill=p["jade"] if n == cur else p["ash"], font=small)
        x = draw_runs(d, 56, y, runs, fonts)
        if n == cur:
            d.rectangle([W - 260, y - 2, W - 250, y + 22], fill=p["cursor"])
            seg = fonts[(0, 0)].getlength('"ash"')
            # terminal-style selection on the string
            sx = 56 + sum(fonts[(b, i)].getlength(s) for s, _, b, i, _ in runs[:9])
            d.rectangle([sx, y - 4, sx + seg, y + lh - 6], fill=p["selection"])
            d.text((sx, y), '"ash"', fill=p["elixir"], font=fonts[(0, 0)])

    # tfvars panel
    top2 = top + 24 + lh * len(lines) + 40
    lines2 = tfvars(p)
    rounded(d, [36, top2, W - 36, top2 + 24 + lh * len(lines2) + 12], p["surface"])
    for n, runs in enumerate(lines2):
        draw_runs(d, 56, top2 + 18 + n * lh, runs, fonts)
    return im


if __name__ == "__main__":
    pal = tomllib.loads((ROOT / "palette.toml").read_text())
    which = pal["order"] if len(sys.argv) > 1 and sys.argv[1] == "all" else PREVIEWS
    for v in which:
        render(v).save(ROOT / "assets" / f"preview-{v}.png")
    print(f"wrote {len(which)} previews")
