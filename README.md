# Fever Dream (Sharpee)

A perceptual horror. Three items alter your perception. The world stays the same. You do not.

Play it on IF Hub: https://johnesco.github.io/ifhub/app.html?game=fever-dream-sharpee

Written in [Chord](https://sharpee.net/chord/) for the [Sharpee](https://sharpee.net) engine. The whole game is `fever-dream-sharpee.story`. It is a translation of the TypeScript edition (kept in `legacy/`), which was itself a port of the Inform 7 original. Eight sound cues from that original live in `assets/sfx/`.

## Building

This game is built and published from the Sharpee workspace, which holds the shared tooling:

```
npx sharpee play                                        # play in the terminal
npx sharpee test                                        # replay fever-dream-sharpee.tests.json
python ../tools/build.py fever-dream-sharpee --force    # gates, build, tests, lay out the hub folder
python C:/code/ifhub/tools/ship.py fever-dream-sharpee  # publish and list on IF Hub
```

## Walkthrough

take spectacles, wear spectacles, east, down, take wrench, south, read plaque,
break glass case with wrench, east, unlock cabinet with brass key, open cabinet,
take fungus, west, eat fungus, south, turn valve left, down, touch basin.

Turning the valve right instead is the other ending.
