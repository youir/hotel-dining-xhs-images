---
name: hotel-dining-xhs-images
description: Produce, refine, QA, and package 3:4 Xiaohongshu-style hotel, guest-room, restaurant, banquet, café, beverage, dessert, and afternoon-tea images from real venue photos and bundled visual references. Use when Codex needs to plan hotel or dining shot lists, generate fresh lifestyle images, improve images that feel staged, dark, empty, unnatural, or lack “网感”, create static soft-focus people or empty-space variants, preserve real architecture and food facts, export exact 1080×1440 PNGs, or deliver contact sheets and manifests.
---

# Hotel & Dining Xiaohongshu Images

Produce publishable Xiaohongshu image sets that feel observed rather than staged. Preserve the venue as fact; use references only for composition, light, depth, and social-editorial rhythm.

## Route the task

Read only the references needed for the current work:

- For any production or revision, read [workflow.md](references/workflow.md).
- For shot planning or “再做一些”, read [shot-library.md](references/shot-library.md).
- Before generating, read [prompt-patterns.md](references/prompt-patterns.md).
- Before selecting, exporting, or delivering, read [qa-and-delivery.md](references/qa-and-delivery.md).
- When choosing bundled references, read [reference-library.md](references/reference-library.md), then inspect the selected images with `view_image` before each generation call.

Use the installed `imagegen` skill and built-in image generation for raster creation or editing. Do not use Python as a substitute for image generation or visual retouching.

## Non-negotiable principles

1. Treat real venue images as ground truth for architecture, furniture, window structure, view, table shape, and major materials.
2. Treat Xiaohongshu references as style-only evidence. Do not copy their city, venue, person identity, text, logos, or platform watermark.
3. Convert “网感” into measurable choices: environment 60–75%, person 10–30%, off-axis placement, partial crop, one foreground layer, one clear subject hierarchy, natural dynamic range, and incomplete observed framing.
4. Default to bright, clear, neutral daylight when the user says 清透 or 明亮: bright background dominates, whites stay clean, greenery stays soft, and shadow detail remains visible.
5. Do not equate atmosphere with underexposure. Dark images require explicit user intent such as 蓝调、烛光 or 夜景.
6. For dining and afternoon tea, never leave the table narratively empty. Use a coherent minimum table-setting system from [shot-library.md](references/shot-library.md).
7. Default people to still seated, leaning, or standing poses. Do not add walking, motion blur, or a visible face unless the brief asks for it.
8. Generate each selected composition independently. When a user rejects composition, lighting, naturalness, or table richness, create a fresh version instead of repeatedly redrawing an already generated image.
9. Preserve every previous version. Write a new `_vNN` file and never overwrite or delete accepted or historical assets.
10. Deliver exact `1080×1440` RGB PNGs, visually inspected at full frame and corners, with no readable text, logo, QR code, or watermark.

## Core workflow

1. Read the article, image requirements, venue index, and real source photos.
2. Assign every source one role: `venue_ground_truth`, `style_only`, or `person_identity_only`. Never let style references override venue facts.
3. Build a shot matrix before generation: article section, shot ID, subject, person treatment, props, light, lens/framing, title-safe area, and reference paths.
4. Select one real venue image and one to three relevant bundled style references per shot. Inspect all selected images immediately before generating.
5. Write prompts with explicit blocks for output, source roles, composition, person, table/props, exposure, realism, and negatives.
6. Generate independent 3:4 candidates. Keep one visual idea per call; use versioned filenames.
7. QA venue truth, composition, exposure, anatomy, props, text/watermarks, and exact pixels. Reject rather than rationalize failures.
8. Normalize approved images with [normalize_3x4.sh](scripts/normalize_3x4.sh). Use a safe crop only when it preserves the intended composition.
9. Create a contact sheet with [make_xhs_contact_sheet.swift](scripts/make_xhs_contact_sheet.swift), record provenance and SHA-256, and run [audit_delivery.sh](scripts/audit_delivery.sh).
10. Present the strongest sequence, not merely all generated files. State which historical variants are no longer recommended while retaining them.

## Revision rules

Translate feedback into a new hard constraint:

- “比例不对” → verify real pixels, export exact 1080×1440, and report dimensions.
- “构图不自然/没网感” → reduce centered symmetry; increase environmental share, edge crop, foreground depth, and observed-camera feel.
- “太暗沉” → make bright background occupy about two-thirds; preserve neutral whites and shadow detail; remove dusk wording.
- “人物不要走” → use one static seated/standing figure, soft-focus profile, back, shoulder, or hand; forbid motion blur.
- “桌上寒酸/不能空” → apply the full two-person tea or dining baseline; keep the arrangement abundant but not banquet-like.
- “重绘会加噪点” → generate a new composition from venue and style sources only; do not feed the rejected generated image back as a reference.

If a user correction conflicts with an earlier style direction, prioritize the correction and record the superseded direction in the delivery notes.

## Output contract

For each approved asset, preserve:

- deterministic shot ID and descriptive Chinese filename;
- version number and generation date;
- selected source paths with roles;
- prompt summary, chosen attempt, crop/scale transform, dimensions, and SHA-256;
- visual QA result for venue, person, props, exposure, text/logo/watermark, and exact size.

Use `assets/reference-images/` as the internal style library. It contains 53 source reference images grouped by hotel people, hotel scenes, restaurant people, and restaurant scenes.
