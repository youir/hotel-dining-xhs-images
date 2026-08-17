# Production workflow

## Contents

1. Intake and source roles
2. Shot matrix
3. Reference selection
4. Generation
5. Iteration
6. Packaging

## 1. Intake and source roles

Read the target directory `index.md` before opening assets. Then read the article or brief and extract every requested image into a checklist.

Classify sources before prompting:

| Role | Controls | Must not control |
|---|---|---|
| `venue_ground_truth` | walls, furniture, windows, view, materials, table geometry | social-media pose or color grading |
| `style_only` | composition, camera distance, exposure, depth, crop, mood | venue facts, city, signs, identity |
| `person_identity_only` | recurring model identity or wardrobe continuity | venue, pose, table setting |

If no usable venue source exists, pause before inventing a commercially material space fact. If only the view is obscured, retain the obscured or nearby-tree condition instead of generating a clearer river or skyline.

## 2. Shot matrix

Create a compact matrix before generation:

| Field | Example |
|---|---|
| Article/section | 霞光厅下午茶 |
| Shot ID | B19 |
| Role in post | atmosphere opener |
| Main subject | bright window + prepared afternoon tea |
| Person | one static right foreground blur, 15% |
| Environment | 65–75% |
| Props | three-tier stand, teapot, two cup sets, flowers, napkins |
| Light | neutral bright daylight, shadow detail |
| Framing | vertical 3:4, off-axis, partial foreground |
| References | one venue source + one composition source |

Balance a set across five functions:

1. cover or establishing image;
2. space proof;
3. person/lifestyle relation;
4. food, drink, or object detail;
5. transition or quiet atmosphere image.

Avoid five images that repeat the same centered full-room angle.

## 3. Reference selection

Choose references by visual problem, not by filename similarity:

- Need a static soft-focus person: choose a hotel-person reference with a bright background and edge-cropped figure.
- Need a natural room image: choose a hotel-scene reference with negative space or partial foreground.
- Need a rich table: choose a restaurant-scene reference that shows hierarchy, not maximum object count.
- Need believable interaction: choose a restaurant-person reference with hands, gaze, or over-shoulder framing.

Inspect the selected venue source and every style reference with `view_image` before each image-generation call. Do not rely on memory or a previous inspection from another shot.

## 4. Generation

Generate each shot independently from the real venue source and selected style references. Do not use a rejected generated image as the next reference when the rejection concerns composition, lighting, naturalness, anatomy, or noise.

Use one primary camera idea per shot:

- 35 mm environmental observation;
- 50 mm mid-distance lifestyle frame;
- 70–85 mm compressed detail or foreground silhouette.

Avoid mixing wide-room, portrait, flat lay, and product-ad directions in one prompt.

When producing a set, vary only one or two axes at a time: person/no person, camera height, or subject distance. Preserve the same venue facts and overall color logic.

## 5. Iteration

Map feedback to the earliest failed decision:

| Feedback | Failed decision | Corrective action |
|---|---|---|
| ratio wrong | export | inspect pixels and normalize |
| unnatural | framing/pose | make pose static, crop off-axis, add foreground depth |
| no social feel | hierarchy | raise environment share and observed-camera incompleteness |
| too dark | exposure language | remove dusk/cinematic terms; specify bright neutral background |
| table looks poor | prop system | add a coherent minimum setting, not random items |
| redraw looks noisy | generation strategy | start a fresh version from source roles |

Use a new version number after every material change. Do not overwrite previous outputs.

## 6. Packaging

For each delivery group:

1. export exact 1080×1440 PNGs;
2. generate a contact sheet with shot labels;
3. write a JSON manifest with references, transforms, SHA-256, and QA;
4. update the project delivery note without deleting history;
5. identify the recommended sequence and superseded variants;
6. provide direct links to the final directory and contact sheet.
