# Prompt patterns

## Prompt architecture

Write prompts in this order:

1. **Output** — fresh generation, vertical 3:4, real lifestyle photography.
2. **Source roles** — state exactly what each reference controls and must not control.
3. **Venue facts** — list only the architecture and view visible in the real source.
4. **Composition** — subject shares, camera position, crop, foreground, focus plane.
5. **Person** — count, static pose, face visibility, hand visibility, wardrobe if needed.
6. **Table/props** — explicit object count and arrangement logic.
7. **Exposure/color** — bright-area share, white balance, shadow behavior.
8. **Realism** — lens feel, natural materials, restrained processing.
9. **Negatives** — facts and artifacts that must not appear.

Avoid bare adjectives such as “高级、网感、氛围感”. Pair every adjective with visible evidence.

## Source-role block

```text
第一张参考图只用于锁定真实空间：墙面、窗框、家具、桌型、材质和真实窗景。
第二张参考图只借鉴构图、景深、亮度关系和人物在边缘的虚焦处理；不得复制其城市、建筑、人物身份、文字或水印。
```

## Bright static-person afternoon tea

```text
全新生成一张竖版3:4的真实酒店生活方式摄影，不在任何旧生成图上重绘。
真实空间与窗外近树景占画面65%–75%，窗景和下午茶桌面清楚对焦。
唯一一位成年人物静止坐在最右侧近景，只呈柔焦头肩侧面轮廓和一只自然扶杯的手；不看镜头、不走路、无运动拖影，脸部不可辨。
桌面完整布置双人下午茶：一只三层点心架，五至九枚司康、水果塔、马卡龙和小三明治；一只白瓷茶壶；两组杯碟；两只甜品盘；一束低矮浅色花艺；两块自然折叠的浅色餐巾；两只透明水杯。丰盛但有留白，不做宴会堆叠。
日间中性偏冷自然光，亮背景约占三分之二；白色干净，绿叶通透，暗部有纹理，不使用黄昏、厚重电影调色或高反差HDR。
真实35–50mm抓拍感，透视自然、低颗粒。
严禁虚构城市、大江、招牌、文字、Logo、二维码、平台水印、多余人物、畸形手指和重复杯具。
```

## Bright no-person table scene

```text
完全无人。偏轴低机位拍摄窗边已经布置好的双人下午茶，前景一角由柔焦椅背或纱帘形成层次。
三层点心架、茶壶、双杯碟、甜品盘、花艺、餐巾和水杯清楚可见，近处器物允许自然裁切。
像客人到场前刚布置好的生活方式照片，不像商品目录或宴会宣传照。
```

## Hotel room static silhouette

```text
窗景与真实客房占画面70%，人物只占右侧10%–20%。人物静止坐着或靠窗，身体和侧脸自然焦外，不看镜头；只保留一个清楚的手部关系。
亮窗主导但不过曝，床品和暗色家具仍有层次。禁止行走、拖影、城市替换、正中站姿和磨皮人像感。
```

## Negative library

Select only relevant negatives; do not overload the prompt:

- no invented skyline, unobstructed river, moon, or landmark;
- no empty table, single-cup-only setup, random duplicate tableware, or banquet overload;
- no centered catalog pose, direct gaze, walking, motion trail, doubled face, or extra limbs;
- no crushed blacks, orange cast, neon greenery, HDR halos, excessive grain, or synthetic glow;
- no readable text, logo, menu, brand mark, QR code, app watermark, or corner signature;
- no replacement of permanent venue architecture with reference architecture.
