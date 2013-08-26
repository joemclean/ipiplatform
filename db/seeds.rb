# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Default Admin', email: 'admin@example.com', password: '0000', password_confirmation: '0000', is_admin: true)
User.create(name: 'Default User', email: 'test@example.com', password: '0000', password_confirmation: '0000', is_admin: false)

require 'csv'    

csv_text = File.read('db/resources.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  resource = Resource.create!(row.to_hash)
end

analyst_responses = ['I excel at understanding intricate problems.',
'I believe it is important to consider all possibilities before acting',
'I believe decisions should be based on evidence.',
'I think the past contains clues to future possibilities',
'I find my ability to catch small mistakes to be of great value.']

visionary_responses = ['I think about the way the world could be',
'I am comfortable with doing things without planning',
'I enjoy working in environments or on problems that are abstract',
'I listen to my gut when making decisions',
'The impossible is more interesting to me than the possible']

maverick_responses = ['I find great joy in losing myself in a task.',
'At the end of the day, I prefer to spend time alone to recharge',
'I enjoy working independently prior to presenting my findings to my team.',
'I excel at tasks that I can perform alone.',
'I derive great satisfaction from crossing things off a list']

team_player_responses = ['I am happy to take on different roles within a team',
'I think decisions should be made democratically',
'I confer with others before making significant choices',
'I enjoy giving and receiving positive feedback',
'Having teammates makes me work harder']

adventurer_responses = ['I prefer to act quickly in order to get immediate feedback',
'I am good at finding quick and easy solutions to problems',
'I solve problems by trying out different solutions rather than thinking about solutions.',
'I often find my instinctual responses to be correct.',
'I find action to be an integral part of my thinking process.']

anchor_responses = ['I prefer to identify potential obstacles before acting',
'I prefer certainty',
'When making choices I rely on the facts at hand',
'I prefer tried and tested methods',
'I need to see it to believe it']

altruist_responses = ['I believe doing good for others is its own reward',
'I believe the world would be a better place if everyone acted in the interest of the collective good',
'I devote a portion of my free time to socially responsible causes',
'Giving back is very important to me',
'People often describe me as selfless',]

enterpriser_responses = ['I need to be recognized for my efforts',
'I want to be known for my achievements',
'I expected to be compensated for my work',
'Personal advancement is important to me',
'Every project I do should improve my skills']

straight_liner_responses = ['I would describe my work style as disciplined',
'I believe the best way to find the solution to a problem is by attacking it in a structured fashion',
'I believe formalized processes make everything easier',
'When solving a problem, I would rather follow a familiar approach than seek a new one',
'I try to minimize deviation from my plan']

zig_zagger_responses = ['When working on a project, I like to follow wherever the process leads me',
'I think play is a great way to approach problems',
'I think a little chaos is good for the creative process',
'I like juggling multiple ideas at once',
'I am comfortable making rapid decisions']

maverick = [
    'Maverick',
    'They call you something of a lone wolf (that’s right, we said it). You are an incredibly independent person, and you prefer those moments when you can quietly reflect on the outcomes of collaboration. In many ways you are a disruptive force—you present ideas that may guide your group in a different direction than they were headed. Your value in the innovative process is to really challenge the group, and produce ideas that may appear to have come out of nowhere. Your inclination towards introspective reflection brings strong and well-thought out ideas to the table.',
    maverick_responses,
    'maverick.png'
  ]

team_player = [
    'Team Player',
    'They call you something of a collaborative powerhouse (excuse me, what?). You believe in the inherent value of ideas that emerge out of the collision of different minds and different people. You try your best to ensure that the potential of each colleague is fully tapped into, and that each and every voice is heard throughout the problem-solving process. In innovation, your point of view helps to guarantee that all of the different influences within a system are factored into the final outcome. Your inclination towards empathy and a democratic approach is bar none.',
    team_player_responses,
    'team_player.png'
  ]
straight_liner = [
    'Straight Liner',
    'Some people might call you obsessive, but we’d prefer to call you rigorous. You believe that methodologies are tried, tested and true, so why mess with them? This means that you are hesitant to try new tactics, because you know that your methodology will work. As a matter of fact, you’d rather spend your time building out those tactics as opposed to reconfiguring them. As an innovator, you question the idea of reinventing the wheel when it already works so well. Instead, you find the idea of reinventing the way we use a wheel more exciting.',
    straight_liner_responses,
    'straightliner.png'
  ]
zig_zagger = [
    'Zig-Zagger',
    'You’re kind of erratic, but we mean that in the best way possible. You believe that methodologies should adapt as the problem takes on a new shape. You spend your time applying new methodologies, and often look towards other industries for insight into new ways to approach a certain scenario. This means that you don’t necessarily approach a problem with a set plan in mind, even though you have an arsenal of tactics to draw from. As an innovator, you are a wealth of knowledge when it comes to garnering methodologies.',
    zig_zagger_responses,
    'zigzagger.png'
  ]
enterpriser = [
    'Enterpriser',
    'You are driven by external rewards, and deeply believe in the value of authorship over your ideas. It’s a big bad world out there, and you want to claim the impact that you are responsible for having created. You are not selfish, but rather, you are headstrong and believe that good work should receive the appropriate accolades. In innovation, you believe that it’s important to instigate personal growth and ensure that the community knows that you and your team are responsible for any of your successes. ',
    enterpriser_responses,
    'enterpriser.png'
  ]
altruist = [
    'Altruist',
    'You are an idealist—you believe in the greatest amount of good for the greatest number of people. Your drive to do groundbreaking work is motivated by your internal pride and satisfaction. You don’t necessarily need to see your name posted on the plaque. Rather, you just want to know that your work has had an impact. In innovation, you believe that impact should be at the forefront of every great idea. Save the people!',
    altruist_responses,
    'altruist.png'
  ]
adventurer = [
    'Adventurer',
    'You’ve got guts, and those guts are always telling you what to do. The thing is, you don’t really challenge them. Instead, you go with them without hesitation or question. This willingness to take chances has helped you to adapt to the most precarious of situations. Because of this, you’re not afraid to act as quickly as you possibly can, no matter what stands in your way. In innovation, your swiftness and agility enables you to create and reiterate just as fast as Wile E. Coyote.',
    adventurer_responses,
    'adventurer.png'
  ]
anchor = [
    'Anchor',
    'You’ve got a little guy sitting on your shoulder, and he’s always telling you what to do: slow down, think it through, take your time. This voice in your head is always making you step back, and really reflect on the situation at hand. Your moves are always very calculated and well thought-out. You are a strategist at heart, and prefer to plot out each move as opposed to just react off hand. In innovation, you help to ensure that each move is created with a wee bit of reality and a large dash of practicality.',
    anchor_responses,
    'anchor.png'
  ]
analyst = [
    'Analyst',
    'You’re like an astronaut tethered to her spaceship—you’re willing to explore, but only when you have a connection back to earth. You thrive on numbers and statistics, and need to establish precendents before you can proceed with your idea. This desire for tangibility makes you bring a level of objectivity to any and every project. In innovation, you bring a very micro-lens to the table that ensures that all of the details of an idea are solid and in place.',
    analyst_responses,
    'analyst.png'
  ]
visionary = [
    'Visionary',
    'You’re like the best dream you’ve ever had—you’re nothing but imagination and ingenuity. Your tendency to think outside of the box creates completely inspirational and spontaneous ideas. You don’t really care what happens before or after your great idea, because your main motivation is to really extend the mind, and create something that is unlike anything anyone’s ever seen before. When it comes to innovation you’re the big bang that started the Universe.',
    visionary_responses,
    'visionary.png'
  ]

spectrum_names = [
  ['Collaboration', [maverick, team_player], 'Are you a “people-person” or do you prefer to go your own way? Your approach to working with others can have a big impact on the development of your project.'], 
  ['Risk', [anchor, adventurer], 'Some people avoid iffy situations while others run toward them. Knowing your tolerance for uncertainty can help you assess project-related opportunities and how to act on them.'], 
  ['Process', [straight_liner, zig_zagger], 'Does following a recipe to the letter fill you with dread? Or, does the idea of checking what’s in the fridge and winging it, make you break out in a sweat? Your method for making decisions and taking action can strongly affect your project’s development.'], 
  ['Style', [analyst, visionary], 'Do you have an eye for the details, or are you drawn to grand concepts? Whether a stickler for the particulars, or someone who prefers looking at the big picture, a solid understanding of your affinity can play to your strengths when project planning.'], 
  ['Drivers', [altruist, enterpriser], 'Your motivations are the final piece in the Innovation Type puzzle. Knowing what brings you ultimate satisfaction from a project delivery standpoint helps you frame both outcomes and your work with others.']
]

Spectrum.delete_all
Trait.delete_all
QuestionResponse.delete_all
spectrum_names.each do |name, trait_pair, spectrum_description|
  spectrum = Spectrum.find_or_create_by_name_and_description(name: name, description: spectrum_description)
  trait_pair.each do |name, trait_description, responses, image|
    trait = spectrum.traits.create(name: name, description: trait_description, image: image)
    responses.each do |response|
      trait.question_responses.create(response: response)
    end
  end
end

industries = [
  'Does not matter',
  'Education',
  'Finance',
  'Travel',
  'Retail',
  'Media',
  'Hospitality',
  'Healthcare',
  'Hardware Technology',
  'Software Technology',
  'Energy'
]

Industry.delete_all
industries.each do |industry|
  Industry.create(name: industry)
end

phases = [
  'Plan',
  'Act',
  'Observe',
  'Reflect'
]

Phase.delete_all
phases.each do |phase_name|
  Phase.create(name: phase_name)
end

media = [
  'Text',
  'Audio',
  'Video',
  'Web',
  'App'
]

format_types = [
  'Article',
  'Tutorial',
  'Game',
  'Book'
]

media.each do |medium|
  Medium.create(name: medium)
end
format_types.each do |format_type|
  FormatType.create(name: format_type)
end

