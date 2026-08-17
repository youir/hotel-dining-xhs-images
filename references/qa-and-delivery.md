# QA and delivery

## Visual QA sequence

Inspect every candidate in this order:

1. **Full-frame hierarchy** — Does the intended subject read at thumbnail size?
2. **Venue truth** — Are walls, furniture, windows, view, and materials consistent with the real source?
3. **Exposure** — Are whites neutral, greenery controlled, highlights textured, and shadows readable?
4. **Person** — Count people, faces, hands, fingers, and limbs. Confirm the intended pose is static or dynamic.
5. **Props/food** — Count cups, plates, teapot, serving stands, foods, flowers, and napkins. Check structural plausibility and table richness.
6. **Text/watermark** — Inspect the entire frame and all four corners at high magnification.
7. **Technical** — Verify format, dimensions, aspect ratio, color mode, filename, and version.

Never accept a candidate solely because the overall mood is attractive.

## Rejection conditions

Reject or regenerate when any of these occur:

- venue architecture or window view is materially invented;
- person is oversized, centered, walking when not requested, or anatomically broken;
- face is crossed by a mullion or duplicated in reflection;
- table is empty, under-styled, physically incoherent, or crowded like a banquet;
- food or drink count contradicts the brief;
- image is globally dark when the brief says bright or clear;
- any readable text, logo, QR code, signature, or platform watermark remains;
- output is not exact 3:4 after final export.

For a tiny mark at a safe outer edge, a 3:4 edge crop is allowed only after confirming that it preserves the subject and venue evidence. Otherwise regenerate. Do not blur, paint over, or repeatedly redraw the image to hide it.

## Technical target

- final format: PNG;
- dimensions: exactly 1080×1440;
- aspect ratio: 3:4;
- color: RGB;
- metadata: remove unnecessary metadata;
- naming: `{shot_id}_{short_chinese_description}_vNN.png`;
- never overwrite an existing version.

Use `scripts/normalize_3x4.sh` for deterministic crop and scale. Use `scripts/audit_delivery.sh` for the batch technical pass.

## Contact sheet

Create a labeled contact sheet after individual QA. Labels should include shot ID and a short direction, not filenames or prompt text. Contact sheets are for selection only and must not replace the final 1080×1440 files.

Use:

```bash
swift scripts/make_xhs_contact_sheet.swift OUTPUT.png TITLE LABEL IMAGE [LABEL IMAGE ...]
```

## Manifest minimum

Record:

```json
{
  "id": "B19",
  "file": "B19_窗边静坐丰盛下午茶_清透版_v03.png",
  "generation_mode": "built-in imagegen; fresh generation",
  "references": [
    {"path": "...", "role": "venue_ground_truth"},
    {"path": "...", "role": "style_only"}
  ],
  "dimensions": "1080x1440",
  "export_transform": "safe 3:4 crop + Lanczos scale",
  "sha256": "...",
  "qa": {
    "venue_truth": "pass",
    "person_anatomy": "pass",
    "table_richness": "pass",
    "bright_clear_exposure": "pass",
    "text_logo_watermark": "none detected"
  }
}
```

## Final handoff

State:

- how many approved images were delivered;
- exact dimensions and format;
- what changed from the rejected direction;
- which files are recommended and which older versions are retained but superseded;
- direct links to the final directory, contact sheet, and delivery note.
