# Bundled reference library

The skill contains 53 Xiaohongshu reference images in `assets/reference-images/`. Preserve the original filenames for traceability.

## Categories

| Folder | Count | Use for |
|---|---:|---|
| `酒店人物拍摄/` | 27 | static edge-cropped people, robes, window poses, reflections, natural lifestyle framing |
| `酒店景拍摄/` | 3 | room negative space, window-led compositions, object-to-view scale |
| `餐厅人物拍摄/` | 9 | seated interaction, hands, over-shoulder framing, person-to-table balance |
| `餐厅场景/` | 14 | table hierarchy, food/drink styling, restaurant light, empty-space transitions |

## Selection procedure

1. Start from the required visual problem.
2. Search filenames in the relevant category with `rg --files assets/reference-images/<category>`.
3. Inspect likely files with `view_image` at original detail.
4. Select one to three references whose composition and exposure agree.
5. Assign each selected reference a narrow role in the prompt.

Do not attach all 53 images to one generation. More references do not guarantee better control and can corrupt venue facts.

## Style-use boundaries

- Use the images to learn camera distance, crop, light ratio, depth, and interaction.
- Do not reproduce a specific person's identity or distinctive outfit.
- Do not copy background buildings, signs, restaurant furniture, or a city view into the user's venue.
- Do not retain source text, logos, signatures, or Xiaohongshu watermarks.
- Do not publish the bundled references as deliverables; they remain internal style evidence.

## Useful search cues

- Bright static foreground person: search `staycation` in `酒店人物拍摄/`.
- Window and room composition: inspect all three files in `酒店景拍摄/`.
- Seated dining interaction: search `餐厅拍照` in `餐厅人物拍摄/`.
- Rich afternoon tea or table hierarchy: inspect `餐厅场景/` and select by visual evidence rather than title.
