# Demand the Screen — Creative Kit

Static host for the captain / ambassador creative kit: `index.html` plus `images/`.

Generated. **Do not edit here** — the build overwrites `index.html` and `images/`.
Source and build scripts live in the campaign folder at
`04-COPY-AND-CREATIVE/2026-08-31_Creative-Kit/_source/`:

```bash
./venv/bin/python build_site.py --base <public base url>
```

The build clears only `index.html` and `images/`; `.git`, this README, `.nojekyll`
and `CNAME` are left alone.

Only stills released through the current drip week are published. Unreleased frames
are never written into `dist/`, so they are not files in this repository.
