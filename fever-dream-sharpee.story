## Fever Dream — a perceptual horror. Three items alter your perception.
## The world stays the same. You do not.
##
## Chord edition, translated from the TypeScript original (now in legacy/src/)
## on 2026-09-08. The perception mechanic is the story's own state: normal,
## then clarity when the fungus is eaten, then corruption when the spray hits.
## Prose that changed in place in the TypeScript now hangs off those states.

story
  title: Fever Dream
  authors:
    John Googol
  id: fever-dream-sharpee
  story-version: 2.0.0
  ifid: B00BC21D-58F3-41B6-BEC5-EF7C33C246B3
  description: A perceptual horror. Three items alter your perception. The world stays the same. You do not.
  themes: modern-dark, retro-terminal, paper, system-6
  states: normal, clarity, corruption

## ===========================================================================
## THE WARD — upper level
## ===========================================================================

create the Receiving Room
  a room
  aka reception, lobby
  east to the Corridor

  Fluorescent tubes buzz overhead, one flickering at the far end. A long
  counter divides the room — scuffed linoleum on your side, dark wood on the
  other. A door leads east.

create the Corridor
  a room
  aka hallway, hall
  east to the Treatment Room
  down to the Stairwell
  down is blocked while the trapdoor is hidden: no-trapdoor

  A long hallway tiled in white. Several tiles are cracked, revealing raw
  concrete beneath. The receiving room is west. The treatment room is east.

  phrase detail while not normal:
    The tiles pulse faintly, expanding and contracting like something
    breathing. The cracks between them are veins. The hallway is a throat
    and you are inside it.

create the Treatment Room
  a room
  aka treatment

  A reclining chair bolted to the floor, surrounded by drainage channels cut
  into the concrete. Instrument trays line the east wall. A faded note is
  pinned to the wall. The corridor is west.

## ===========================================================================
## THE BASEMENT — middle level
## ===========================================================================

create the Stairwell
  a room
  aka stairs, steps
  south to the Laboratory

  Concrete steps descend to a landing. The air turns cold and damp. Pipes run
  along the ceiling, sweating with condensation. The trapdoor opens above. A
  passage continues south to the laboratory.

create the Laboratory
  a room
  aka lab
  east to the Cold Storage
  south to the Cistern
  south is blocked while normal: no-south-exit

  A long room lined with workbenches and glass-fronted cabinets. Everything
  is labeled in the same careful handwriting. The stairwell is north. A heavy
  door leads east to cold storage.

  phrase detail while not normal:
    At the south end, the floor has split open — a wound with smooth,
    glistening edges. A dark passage descends through it.

create the Cold Storage
  a room
  aka cold room, freezer, storage

  The temperature drops immediately. Your breath fogs. Racks of specimen jars
  line the walls, filled with amber fluid. A heavy metal cabinet stands
  against the far wall, marked with a snowflake. The laboratory is west.

## ===========================================================================
## THE DEPTHS — lower level
## ===========================================================================

create the Depths
  a region
  containing the Cistern, the Source

  after the player entering
    play ambient drone-horror when client has sound
  end after

  after the player leaving
    stop ambient when client has sound
  end after

create the Cistern
  a room
  aka chamber, water chamber
  down to the Source
  down is blocked while the iron valve is idle: no-drain
  states: sealed, breached

  A circular chamber of old brick.

  phrase detail while normal and the iron valve is idle:
    The chamber is half-filled with dark water. The walls are slick with
    mineral deposits. Pipes enter from above, some intact, some cracked and
    leaking. An iron valve protrudes from the north wall at chest height. A
    faded instructional sign hangs beside it. The passage back north climbs
    toward the laboratory.

  phrase detail while clarity and the iron valve is idle:
    The chamber is alive. The bricks are teeth in a circular jaw. The dark
    water below is a throat, swallowing and unswallowing in slow rhythm. The
    pipes overhead are arteries, pulsing with something that is not water.
    An iron valve grows from the north wall like a bone spur. Beside it, a
    sign hangs from the flesh of the wall. The passage back north climbs
    toward the laboratory.

  phrase detail while corruption and the iron valve is idle:
    Th3 chamb_r is al1ve. The brikcs are t33th in a circuler jaw. Th3 dark
    watr below is a thro@t, swllowing and unswll0wing. An ir0n valv3 gros
    from the n0rth wall. Bes1de it, a s1gn. The pa55age back n0rth climbs
    t0ward the lab0ratory.

  phrase detail while the iron valve is turned:
    The water is gone. The walls are coated in pale slime. The drainage
    grate stands open in the floor, revealing a narrow passage descending
    further. The passage back north climbs toward the laboratory.

  after the player entering while clarity, once
    change the Cistern to breached
  end after

create the Source
  a room
  aka the source

  A space that should not exist beneath a building this size. The walls are
  membranes, translucent and veined. Light comes from inside them — a slow
  amber pulse. A low stone basin sits in the center, holding something
  luminous, warm, and waiting.

  after the player entering, once
    play sound wound-open when client has sound
  end after

## ===========================================================================
## THE PLAYER
## ===========================================================================

create the Patient
  a person
  playable
  starts in the Receiving Room

  You are wearing a patient's gown, thin and pale blue. Your hands are steady.

## ===========================================================================
## THE WARD — things
## ===========================================================================

create the fluorescent tubes
  aka tubes, lights, fluorescent lights, fluorescents
  scenery, plural
  in the Receiving Room

  Long glass tubes behind plastic diffusers. One flickers in a broken rhythm.

create the long counter
  aka counter, desk, reception desk
  scenery
  in the Receiving Room

  Waist-high, dividing the room. Your side is scuffed linoleum. The far side
  is dark wood, polished once but not recently. Under the counter, scratched
  into the wood: THEY BUILT DOWN BEFORE THEY BUILT UP.

create the intake form
  aka form, paper, document
  scenery, readable
  in the Receiving Room

  A carbon-copy form on the counter. Your name is written in a handwriting
  you do not recognize.

  on the player reading
    phrase form-text
      Patient exhibits reduced perception. Corrective lenses issued.
  end on

create the spectacles
  aka glasses, lenses, specs, corrective lenses
  wearable, plural
  in the Receiving Room

  Wire-rimmed with thick lenses. They feel heavier than they should.

  after the player wearing, once
    change the trapdoor to revealed
    move the trapdoor to the Corridor
    move the glass case to the Laboratory
    phrase wear-spectacles
      You settle the spectacles on your nose. The lenses are thick, heavy.
      The room sharpens at its edges — details you missed before push
      forward into clarity.
  end after

create the trapdoor
  aka trap door, hatch, door in floor
  scenery
  states: hidden, revealed

  A heavy trapdoor set into the floor, propped open against the wall. A
  recessed handle is set into the frame. Stairs descend into darkness.

create the white tiles
  aka tiles, tile, floor, floor tiles
  scenery, plural
  in the Corridor

  Institutional white. Several are cracked, revealing raw concrete beneath.
  The grout has yellowed with age.

  phrase detail while not normal:
    They breathe. You are certain of this now. Each tile swells slightly on
    the inhale and settles on the exhale. The grout between them is wet and
    warm.

create the reclining chair
  aka chair, recliner, seat, crouching thing, thing
  scenery
  in the Treatment Room

  Padded in cracked leather, tilted fifteen degrees back. Restraint loops
  hang from the armrests.

  phrase detail while not normal:
    It has four legs and a flat back. You know it is a chair. It does not
    look like a chair. Its leather is skin. Its restraints are tendons.

create the instrument trays
  aka trays, steel trays, instruments, bone shelves, shelves
  scenery, plural
  in the Treatment Room

  Stainless steel trays on wheeled stands. Labels read EXTRACTION,
  CALIBRATION, REFINEMENT. All empty.

  phrase detail while not normal:
    They are not steel. They are cartilage, smooth and pale, arranged like
    ribs along the wall.

create the faded note
  aka note, wall note
  scenery, readable
  in the Treatment Room

  A typewritten note pinned to the wall with a single tack. The paper has
  yellowed.

  on the player reading
    phrase note-text
      Re: access to the lower level. What you cannot see is still there. The
      corrective lenses are not optional. They are the first step.
  end on

## ===========================================================================
## THE BASEMENT — things
## ===========================================================================

create the sweating pipes
  aka pipes, ceiling pipes, arteries
  scenery, plural
  in the Stairwell

  Copper and iron pipes bundled with wire, running along the ceiling.
  Condensation beads on their surfaces.

  phrase detail while not normal:
    They pulse. The condensation is warm now, and slightly viscous. These
    are not pipes. They have never been pipes.

create the pipe wrench
  aka wrench, tool
  in the Stairwell

  Heavy steel with a rusted jaw. The grip is worn smooth.

create the workbenches
  aka benches, work benches, tables
  scenery, plural
  in the Laboratory

  Slate-topped benches scored with knife marks and chemical burns. Numbered
  brass plates read 1 through 12, but benches 7 through 10 are missing.

create the lab plaque
  aka plaque, brass plaque
  scenery, readable
  in the Laboratory

  A brass plaque mounted beside the cold storage door.

  on the player reading
    phrase plaque-text
      CISTERN MAINTENANCE — Valve operation: LEFT drains. RIGHT floods. Do
      not operate without authorization.
  end on

create the glass case
  aka case, display case
  scenery, breakable
  states: intact, shattered

  A small display case mounted on the wall. Thin glass, sealed shut. Inside,
  a brass key hangs from a thin wire.

  on the player examining
    phrase case-intact when the glass case is intact
      A small display case mounted on the wall. Thin glass, sealed shut.
      Inside, a brass key hangs from a thin wire.
    phrase case-shattered when the glass case is shattered
      Shattered remains of the display case. Fragments of thin glass cling
      to the frame.
  end on

create the brass key
  aka key, ornate key, snowflake key

  Ornate, warm to the touch. The bow is stamped with a snowflake.

create the specimen jars
  aka jars, specimens, bottles, organs, sacs
  scenery, plural
  in the Cold Storage

  Sealed with wax. Dark shapes suspended in amber fluid, beyond
  identification. Each jar has a patient number. None match.

  phrase detail while not normal:
    Not jars. Transparent sacs of membrane, each holding a dark shape that
    twitches when you look directly at it. They are alive. They have always
    been alive.

create the metal cabinet
  aka cabinet, locker, snowflake cabinet, iron ribcage, ribcage
  scenery, a container, openable, lockable with the brass key
  starts locked
  in the Cold Storage

  Heavy metal, cold to the touch. A snowflake is embossed on the door.

  phrase detail while not normal:
    What you called a cabinet is a cage of fused iron bones. It stands open
    like a chest cavity after surgery.

create the glass dish
  aka dish, petri dish
  scenery, readable
  in the metal cabinet

  A shallow petri dish. A label reads: "PERCEPTUAL AGENT — STAGE 2 THERAPY."

  on the player reading
    phrase dish-text
      PERCEPTUAL AGENT — STAGE 2 THERAPY. CONSUME FOR ACCESS TO LOWER LEVELS.
  end on

create the grey fungus
  aka fungus, gray fungus, mushroom, growth
  edible
  in the metal cabinet

  A dense, velvety mass the color of wet ash. It gives slightly under
  pressure, like bread dough. It smells of nothing.

  after the player eating
    change the story to clarity
    play sound fungus-eat when client has sound
    emit media-transition with kind "fungus" and durationMs 2500 when client has transitions
    phrase fungus-consumed
      It tastes of nothing. Then of everything. The walls ripple once and
      settle into new shapes. You understand, now, that this is not
      distortion. This is clarity. The world has not changed. Your ability
      to see it has.
    phrase lab-floor-opens when the player is in the Laboratory
      The floor at the south end of the laboratory splits open. Not cracks —
      a wound. The edges are smooth and glistening, like muscle tissue
      pulling apart. A dark shaft descends, lined with something that
      contracts slowly as you watch.
  end after

## ===========================================================================
## THE DEPTHS — things
## ===========================================================================

create the dark water
  aka water, pool, liquid
  scenery
  in the Cistern

  Still and black. The surface reflects the pipes above with perfect clarity.

  on the player examining
    phrase water-drained when the iron valve is turned
      Gone. Only pale slime coats the bricks where the waterline was.
    phrase water-normal when the iron valve is idle and normal
      Still and black. The surface reflects the pipes above with perfect
      clarity.
    phrase water-clarity when the iron valve is idle and clarity
      It moves, but you cannot tell which way. Something underneath
      displaces the surface in slow, deliberate patterns.
    phrase water-corrupt when the iron valve is idle and corruption
      Drk watr. It movs but you c4nt tell which w@y.
  end on

create the iron valve
  aka valve, handle, T-handle, t-handle
  scenery, drainable
  in the Cistern
  states: idle, turned

  Cast-iron with a T-shaped handle. It can be turned left or right.

  on the player examining
    phrase valve-normal when normal
      Cast-iron with a T-shaped handle. It can be turned left or right.
    phrase valve-clarity when clarity
      A growth of iron, fused to the wall like coral. The handle is a joint
      that bends left or right.
    phrase valve-corrupt when corruption
      An ir0n valv3. It hs a handl you can trn l3ft or r1ght.
  end on

  on the player turning
    phrase valve-undirected
      The handle can turn left or right. Choose carefully.
  end on

create the instructional sign
  aka sign, instructions, notice
  scenery, readable
  in the Cistern

  A laminated sign mounted beside the valve.

  on the player examining
    phrase sign-normal when normal
      A laminated sign mounted beside the valve.
    phrase sign-clarity when clarity
      A flap of skin pinned to the wall with a thorn. The words are tattooed
      into it. They read the same — valve directions, maintenance notes — but
      the medium has changed.
    phrase sign-corrupt when corruption
      Th3 l3tters sw1m. You c4n alm0st r3ad it.
  end on

  on the player reading
    phrase sign-text when not corruption
      CISTERN VALVE OPERATION — LEFT: drains cistern to sublevel. RIGHT:
      emergency flood (DO NOT OPERATE).
    phrase sign-text-corrupt when corruption
      LEFT dr--ns? Or was 1t R1GHT? Th3 w0rds r3arrange th3mselves wh3n you
      bl1nk.
  end on

create the drainage grate
  aka grate, drain, floor grate
  scenery
  in the Cistern

  A heavy circular grate set into the floor, submerged under the dark water.

  on the player examining
    phrase grate-submerged when the iron valve is idle
      A heavy circular grate set into the floor, submerged under the dark
      water.
    phrase grate-open when the iron valve is turned
      A heavy circular grate, now standing open. A narrow passage descends
      into darkness.
  end on

create the membrane walls
  aka walls, wall, membranes, membrane
  scenery, plural
  in the Source

  They pulse. Shapes move behind them. Not shadows.

  on the player examining
    phrase walls-clear when not corruption
      They pulse. Shapes move behind them. Not shadows.
    phrase walls-corrupt when corruption
      Th3y puls3. Y0u c@n s3e sh4pes m0ving b3h1nd th3m. Th3y ar3 n0t
      shad0ws.
  end on

create the stone basin
  aka basin, bowl
  scenery
  in the Source

  Carved from a single piece of stone, older than anything else in the
  building. It holds something that glows. Not light. Attention.

  on the player examining
    phrase basin-clear when not corruption
      Carved from a single piece of stone, older than anything else in the
      building. It holds something that glows. Not light. Attention.
    phrase basin-corrupt when corruption
      A b@sin c@rved fr0m a s1ngle p1ece of st0ne. Ins1de, s0meth1ng gl0ws.
      1t 1s n0t l1ght. It 1s att3ntion.
  end on

  on the player touching
    play sound basin-touch when client has sound
    win basin-touch
  end on

## ===========================================================================
## VERBS
## ===========================================================================

define trait breakable
  on the player breaking
    the player must hold the pipe wrench: break-need-tool
    it must be intact: break-already
    change it to shattered
    move the brass key to the Patient
    play sound glass-break when client has sound
    emit media-transition with kind "glass" and durationMs 1500 when client has transitions
    phrase break-glass
      You swing the wrench. The glass shatters cleanly. The brass key drops
      into your hand.
  end on
end trait

define trait drainable
  on the player draining
    it must be idle: valve-already-drained
    change it to turned
    play sound valve-screech when client has sound
    phrase valve-left
      Metal screams against metal as you force the valve left. The water
      shudders, then begins to drain — slowly at first, then in a sudden
      rush. The dark water drops, revealing walls coated in pale slime. A
      drainage grate stands open in the floor, revealing a narrow passage
      descending further.
  end on

  on the player flooding
    it must be idle: valve-already-drained
    play sound valve-flood when client has sound
    kill the player valve-right
  end on
end trait

define action breaking
  grammar
    break the target
    smash the target
    shatter the target
    hit the target
    break the target with the instrument
    smash the target with the instrument
    hit the target with the instrument
  the target must be reachable
  otherwise refuse break-cant

define action draining
  grammar
    turn the target left
    turn the target counterclockwise
  the target must be reachable
  otherwise refuse valve-not-here

define action flooding
  grammar
    turn the target right
    turn the target clockwise
  the target must be reachable
  otherwise refuse valve-not-here

extend action touching
  grammar
    reach into the target

## ===========================================================================
## SOUND — assets/sfx/, from the Inform 7 original
## ===========================================================================

define sound glass-break from "sfx/glass.ogg"
define sound valve-screech from "sfx/valve-screech.ogg"
define sound valve-flood from "sfx/flood-rush.ogg"
define sound spray-hiss from "sfx/spray-hiss.ogg"
define sound basin-touch from "sfx/basin-touch.ogg"
define sound fungus-eat from "sfx/fungus-consume.ogg"
define sound wound-open from "sfx/heartbeat.ogg"
define sound drone-horror from "sfx/drone-horror.ogg"

## ===========================================================================
## TEXT
## ===========================================================================

define phrases en-US
  no-trapdoor:
    The floor is solid tile. There is no way down.
  no-south-exit:
    The south wall is solid. There is no exit that way.
  no-drain:
    The grate is submerged under dark water. You cannot go down.
  break-cant:
    Violence will not help here.
  break-need-tool:
    You rap your knuckles against the glass. It holds. You cannot break it
    with your bare hands.
  break-already:
    The case is already shattered. Only fragments remain.
  valve-not-here:
    There is no valve here.
  valve-already-drained:
    The valve is already turned. The cistern is drained.

## The spray hits one turn after the first entry, so the living chamber is
## seen once before the corruption takes it.

define sequence the spray exposure
  when the Cistern becomes breached
  1 turns later
    change the story to corruption
    play sound spray-hiss when client has sound
    phrase spray-exposure
end sequence

define phrase valve-right
  You turn the valve right. A deep groan echoes through the pipes.

  The water surges in. It does not stop. It rises past your waist, your
  chest, your chin. The last thing you see is the ceiling, dark and
  receding.

  The water fills the chamber. It does not stop.
end phrase

define phrase spray-exposure
  A hiss from the cracked pipes overhead. Something cold and chemical
  settles on your skin, your eyes, your tongue. You blink. The letters on
  the sign shift. The walls flicker like a signal losing coherence.

  When your vision steadies, the world has not returned to normal. It has
  gone further.
end phrase

define phrase basin-touch
  You reach in. It reaches back.

  The light expands. It fills your hands, your arms, your chest. You feel it
  behind your eyes — not heat, not cold, but recognition. The building above
  you does not exist. The rooms, the corridors, the instruments — they were
  always this. Membrane and bone and light, folded into shapes you could
  almost name.

  You understand now. You have always been the patient. The treatment is
  complete.
end phrase

before the game starts
  change the player to the Patient
end before
