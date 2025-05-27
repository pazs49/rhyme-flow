# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

firstUser = User.create!(
  email: "percyavon@example.com",
  password: "hello123",
)
firstUser.lyrics.create!(title: "Hello World", body: "Verse 1: Woke up with the sun shining bright, Feeling like everything’s gonna be alright. Stepped outside, took a breath so deep, The world’s alive, and it’s mine to keep.

Pre-Chorus: Every heartbeat sings a melody, Dancing through the air so free.

Chorus: Hello world, it’s a brand new day, Smiles and laughter all the way. Hello world, let’s make it shine, With love and joy, the stars align.

Verse 2: Birds are chirping in the sky so blue, Every color feels so fresh and new. Hand in hand, we’ll chase the light, Together everything feels just right.

Pre-Chorus: Every heartbeat sings a melody, Dancing through the air so free.

Chorus: Hello world, it’s a brand new day, Smiles and laughter all the way. Hello world, let’s make it shine, With love and joy, the stars align.

Bridge: No clouds in sight, just endless dreams, Life’s a song, or so it seems.

Chorus: Hello world, it’s a brand new day, Smiles and laughter all the way. Hello world, let’s make it shine, With love and joy, the stars align.

Outro: Hello world, here we are, Shining bright like a morning star.", genre: "Pop", mood: "Romantic", public: true, user_specific_prompts: "Write an inspirational song about our world!")

firstUser.lyrics.create!(
  title: "Rainy Day Café",
  body: "Verse 1: The sky is gray, the streets are wet, But this little café’s a cozy bet. Steam from the cup, warmth in the air, A gentle hum, peace everywhere.

Pre-Chorus: Drizzle taps the windowpane, But in here, we feel no rain.

Chorus: In this rainy day café, Time just melts and floats away. Soft jazz plays, hearts unwind, Lost in thoughts we rarely find.

Verse 2: The world outside is cold and fast, But in this moment, we make it last. Eyes meet across a book-stained table, We smile, no need for a label.

Pre-Chorus: Drizzle taps the windowpane, But in here, we feel no rain.

Chorus: In this rainy day café, Time just melts and floats away. Soft jazz plays, hearts unwind, Lost in thoughts we rarely find.

Bridge: Raindrops fall like silent grace, But your laugh lights up this place.

Chorus: In this rainy day café, Time just melts and floats away. Soft jazz plays, hearts unwind, Lost in thoughts we rarely find.

Outro: Just you and me and the rain’s ballet, In this rainy day café.",
  genre: "Jazz Pop",
  mood: "Calm",
  public: true,
  user_specific_prompts: "Write a chill, romantic song set inside a cozy café on a rainy day."
)

firstUser.lyrics.create!(
  title: "Digital Heartbeat",
  body: "Verse 1: Screens glow bright in the dead of night, Fingers tap in a neon light. We connect in silent streams, Sharing hopes and coded dreams.

Pre-Chorus: Behind the glass, I see your soul, In every emoji, you make me whole.

Chorus: Digital heartbeat, running through, In this code, I found you. Wireless love, so surreal, But every ping is something real.

Verse 2: Scroll past noise and flashing signs, You and I still realign. Time zones apart, but hearts synced tight, Messaging love into the night.

Pre-Chorus: Behind the glass, I see your soul, In every emoji, you make me whole.

Chorus: Digital heartbeat, running through, In this code, I found you. Wireless love, so surreal, But every ping is something real.

Bridge: Call me pixels, call me stream, You’re the reason I still dream.

Chorus: Digital heartbeat, running through, In this code, I found you. Wireless love, so surreal, But every ping is something real.

Outro: We’re just data in the sky, But this love will never die.",
  genre: "Electropop",
  mood: "Futuristic",
  public: true,
  user_specific_prompts: "Write a love song about online relationships and digital connection."
)

firstUser.lyrics.create!(
  title: "Back to the Roots",
  body: "Verse 1: Dirt on my hands, sun in my eyes, Breathing in truth, shedding the lies. Walking fields where silence speaks, Learning strength from mountain peaks.

Pre-Chorus: Life was louder back in town, But peace lives where roots grow down.

Chorus: Back to the roots, back to the land, Feeling the earth in the palm of my hand. No city lights, just stars above, Reclaiming time, rediscovering love.

Verse 2: Streams still whisper olden songs, Teaching me where I belong. Chopping wood and planting seeds, Finding joy in simple deeds.

Pre-Chorus: Life was louder back in town, But peace lives where roots grow down.

Chorus: Back to the roots, back to the land, Feeling the earth in the palm of my hand. No city lights, just stars above, Reclaiming time, rediscovering love.

Bridge: Every tree tells a tale, Every breeze fills my sail.

Chorus: Back to the roots, back to the land, Feeling the earth in the palm of my hand. No city lights, just stars above, Reclaiming time, rediscovering love.

Outro: I’ve found what truly suits— My heart beats back to the roots.",
  genre: "Folk",
  mood: "Grounded",
  public: true,
  user_specific_prompts: "Write a song about escaping the modern world and reconnecting with nature."
)

firstUser.lyrics.create!(
  title: "Mirror Mirror",
  body: "Verse 1: I look in the glass and I see the doubt, Lines of fear trying to shout. But deep inside, I know the truth, This broken soul still holds youth.

Pre-Chorus: Reflection shows the cracks and scars, But also dreams and shooting stars.

Chorus: Mirror mirror, what do you see? A fighter staring back at me. Through the pain and every fall, I still rise, I still stand tall.

Verse 2: Some days I want to turn away, But the mirror says, 'You’ll be okay.' In every flaw, there’s hidden light, I’m learning now to love the fight.

Pre-Chorus: Reflection shows the cracks and scars, But also dreams and shooting stars.

Chorus: Mirror mirror, what do you see? A fighter staring back at me. Through the pain and every fall, I still rise, I still stand tall.

Bridge: The truth hurts, but it also frees, I am enough—mirror agrees.

Chorus: Mirror mirror, what do you see? A fighter staring back at me. Through the pain and every fall, I still rise, I still stand tall.

Outro: Mirror mirror, now I see— I’m not broken, I’m just me.",
  genre: "Ballad",
  mood: "Empowering",
  public: true,
  user_specific_prompts: "Write a song about self-reflection and inner strength."
)

firstUser.lyrics.create!(
  title: "Neon Jungle",
  body: "Verse 1: Lights flash red, green, and blue, City breathes like a beast let loose. Crowds move fast like rivers roar, Every soul’s looking for more.

Pre-Chorus: Concrete vines climb to the skies, Dreams grow where chaos lies.

Chorus: In this neon jungle, we survive, Electric hearts, we come alive. Under signs that never sleep, We chase thrills and secrets deep.

Verse 2: Sirens howl and stories blur, But your touch is my only anchor. In the chaos, you're my calm, In this madness, you're my balm.

Pre-Chorus: Concrete vines climb to the skies, Dreams grow where chaos lies.

Chorus: In this neon jungle, we survive, Electric hearts, we come alive. Under signs that never sleep, We chase thrills and secrets deep.

Bridge: We're wild things under the chrome, Making this jungle feel like home.

Chorus: In this neon jungle, we survive, Electric hearts, we come alive. Under signs that never sleep, We chase thrills and secrets deep.

Outro: In this neon jungle, side by side, We burn bright, and never hide.",
  genre: "Synthpop",
  mood: "Energetic",
  public: true,
  user_specific_prompts: "Write a high-energy song about life and love in a neon-lit city."
)


secondUser = User.create!(
  email: "ariastone@example.com",
  password: "hello123",
)

secondUser.lyrics.create!(
  title: "Chasing Stars",
  body: "Verse 1: Midnight sky, a trail of light, Dreams awake in the velvet night. We run through fields where fireflies gleam, Holding hands in a cosmic dream.

Pre-Chorus: The wind speaks stories only hearts can hear, Every beat brings the stars near.

Chorus: Chasing stars across the sky, Wishing on the ones that fly. With you, the world fades away, Let’s make the universe sway.

Verse 2: Laughter echoes under moon’s gaze, Lost in each other’s stardust haze. Time slows down in this celestial dance, We found love in a fleeting glance.

Pre-Chorus: The wind speaks stories only hearts can hear, Every beat brings the stars near.

Chorus: Chasing stars across the sky, Wishing on the ones that fly. With you, the world fades away, Let’s make the universe sway.

Bridge: Galaxies spin as we stand still, Love like this bends space to will.

Chorus: Chasing stars across the sky, Wishing on the ones that fly. With you, the world fades away, Let’s make the universe sway.

Outro: In your eyes, I see it all, Chasing stars until we fall.",
  genre: "Indie Pop",
  mood: "Dreamy",
  public: true,
  user_specific_prompts: "Write a dreamy love song about stargazing together."
)

secondUser.lyrics.create!(
  title: "Unbreakable Flame",
  body: "Verse 1: They said I’d fade like dust in the wind, But I rose from ashes again and again. Every bruise built my strength inside, Now I burn with nothing to hide.

Pre-Chorus: They can try, but I won’t fall, I’ve got fire, I’ve got it all.

Chorus: I’m an unbreakable flame, Can’t be tamed, won’t be chained. I rise with every spark, Lighting hope in the dark.

Verse 2: The road was rough, filled with pain, But I danced through every drop of rain. My soul sings loud with fierce pride, The fire in me will never hide.

Pre-Chorus: They can try, but I won’t fall, I’ve got fire, I’ve got it all.

Chorus: I’m an unbreakable flame, Can’t be tamed, won’t be chained. I rise with every spark, Lighting hope in the dark.

Bridge: Burn me down, I’ll ignite, Stronger each time I fight.

Chorus: I’m an unbreakable flame, Can’t be tamed, won’t be chained. I rise with every spark, Lighting hope in the dark.

Outro: I blaze through every name, I’m an unbreakable flame.",
  genre: "Pop Rock",
  mood: "Empowered",
  public: true,
  user_specific_prompts: "Write a fiery anthem about overcoming doubt and proving your strength."
)

thirdUser = User.create!(
  email: "jadenverse@example.com",
  password: "hello123",
)

thirdUser.lyrics.create!(
  title: "Echoes of Youth",
  body: "Verse 1: Skating through the summer air, Music blasting without a care. Memories drawn in chalk and rain, We laughed loud, we felt no pain.

Pre-Chorus: Time slipped through our fingertips, In the golden light of friendships.

Chorus: These echoes of youth still ring so true, In every beat, I think of you. We were wild, we were free, Living life in harmony.

Verse 2: That one song we played on loop, Dancing reckless with our group. City lights and dreams so near, Those days will always be dear.

Pre-Chorus: Time slipped through our fingertips, In the golden light of friendships.

Chorus: These echoes of youth still ring so true, In every beat, I think of you. We were wild, we were free, Living life in harmony.

Bridge: We can’t rewind, but we can sing, To the rhythm that memories bring.

Chorus: These echoes of youth still ring so true, In every beat, I think of you. We were wild, we were free, Living life in harmony.

Outro: In echoes, I still hear our song, And it plays in my heart all along.",
  genre: "Pop",
  mood: "Nostalgic",
  public: true,
  user_specific_prompts: "Write a nostalgic song about your teenage years and good memories."
)

thirdUser.lyrics.create!(
  title: "Waves of the Mind",
  body: "Verse 1: Thoughts crashing like waves on the shore, Can’t escape what I’m thinking anymore. Drowning deep in a silent storm, I smile wide but I’m far from warm.

Pre-Chorus: They don’t see the tide inside, But I’m trying not to hide.

Chorus: Riding waves of the mind, Searching peace I may never find. But I’ll keep swimming, day and night, Chasing the sun, chasing the light.

Verse 2: Pages torn from my mental book, I’ve lost track of what they took. Still I breathe, still I write, Hoping words will make it right.

Pre-Chorus: They don’t see the tide inside, But I’m trying not to hide.

Chorus: Riding waves of the mind, Searching peace I may never find. But I’ll keep swimming, day and night, Chasing the sun, chasing the light.

Bridge: I’m not lost, I’m adrift, Waiting for the winds to shift.

Chorus: Riding waves of the mind, Searching peace I may never find. But I’ll keep swimming, day and night, Chasing the sun, chasing the light.

Outro: In the tide, I’ll find my shore, And I’ll rise again once more.",
  genre: "Alternative",
  mood: "Reflective",
  public: true,
  user_specific_prompts: "Write a poetic song about battling inner thoughts and mental waves."
)
