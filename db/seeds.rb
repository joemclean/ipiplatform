admin = User.new
admin.update_attributes({name: 'Default Admin', email: 'admin@example.com', password: '0000', password_confirmation: '0000', is_admin: true})
user = User.new
user.update_attributes({name: 'Default User', email: 'test@example.com', password: '0000', password_confirmation: '0000', is_admin: false})

blue_responses = ['I excel at understanding intricate problems.',
'I believe it is important to consider all possibilities before acting',
'I believe decisions should be based on evidence.',
'I think the past contains clues to future possibilities',
'I find my ability to catch small mistakes to be of great value.']

green_responses = ['I think about the way the world could be',
'I am comfortable with doing things without planning',
'I enjoy working in environments or on problems that are abstract',
'I listen to my gut when making decisions',
'The impossible is more interesting to me than the possible']

yellow_responses = ['I find great joy in losing myself in a task.',
'At the end of the day, I prefer to spend time alone to recharge',
'I enjoy working independently prior to presenting my findings to my team.',
'I excel at tasks that I can perform alone.',
'I derive great satisfaction from crossing things off a list']

orange_responses = ['I am happy to take on different roles within a team',
'I think decisions should be made democratically',
'I confer with others before making significant choices',
'I enjoy giving and receiving positive feedback',
'Having teammates makes me work harder']

red_responses = ['I prefer to act quickly in order to get immediate feedback',
'I am good at finding quick and easy solutions to problems',
'I solve problems by trying out different solutions rather than thinking about solutions.',
'I often find my instinctual responses to be correct.',
'I find action to be an integral part of my thinking process.']

copper_responses = ['I prefer to identify potential obstacles before acting',
'I prefer certainty',
'When making choices I rely on the facts at hand',
'I prefer tried and tested methods',
'I need to see it to believe it']

gold_responses = ['I believe doing good for others is its own reward',
'I believe the world would be a better place if everyone acted in the interest of the collective good',
'I devote a portion of my free time to socially responsible causes',
'Giving back is very important to me',
'People often describe me as selfless',]

silver_responses = ['I need to be recognized for my efforts',
'I want to be known for my achievements',
'I expected to be compensated for my work',
'Personal advancement is important to me',
'Every project I do should improve my skills']

blue_proposition = [
  'Traditional TW IT Delivery',
  'This client has ambitious ideas and will rely on us to deliver high quality, technically advanced systems on time and in budget.  Our top deliverables are technical prowess, agile leadership, and continuous quality.',
  'visionary.png',
  blue_responses
]

green_proposition = [
  'Fast IT Delivery',
  'green description',
  'adventurer.png',
  green_responses
]

yellow_proposition = [
  'Rapid Incremental Innovation',
  'This established client cares about creativity and speed to hold the lead in a cut throat market: it\'s about out-innovating the competitors.  Our top deliverables are insights, tools, and speed.',
  'analyst.png',
  yellow_responses
]

orange_proposition = [
  'Disruptive Greenfield Innovation',
  'This client is likely at the beginning of an exciting new business venture; their problem is radical re-invention of unproven game changing markets.  Our top deliverables are disruptive vision, lean product learning, and iterative pivots.',
  'enterpriser.png',
  orange_responses
]

red_proposition = [
  'Complex System Innovation',
  'This client is looking for big picture solutions and a full lifecycle execution. Our top deliverables are program vision, integrated solutions, and service design.',
  'anchor.png',
  red_responses
]

copper_proposition = [
  'Agile IT',
  'copper description',
  'team_player.png',
  copper_responses
]

silver_proposition = [
  'Full Product Lifecycle Agile',
  'This client wants innovation capable organizers who work with speed, business engagement, and flexibility.  Our top deliverables are agile process design, side by side delivery, and tools & training.',
  'straightliner.png',
  silver_responses
]

gold_proposition = [
  'Enterprise Agile',
  'gold description',
  'zigzagger.png',
  gold_responses
]

value_propositions = [
    ['Technical Value Propositions', [blue_proposition, green_proposition], 'Technical Value Propositions Description'],
    ['Business Innovation Value Propositions', [yellow_proposition, orange_proposition, red_proposition], 'Business Innovation Value Propositions Description'],
    ['Process Innovation Propositions', [copper_proposition, silver_proposition, gold_proposition], 'Process Innovation Propositions Description']
]

value_propositions.each do |name, color_propositions, value_proposition_description|
  value_proposition = ValueProposition.find_or_create_by_name(name: name, description: value_proposition_description)
  color_propositions.each do |name, color_description, image, question_responses|
    color = value_proposition.colors.find_or_create_by_name(name: name, description: color_description, default_image: image)
    question_responses.each do |response|
      question_response = QuestionResponse.find_or_create_by_response(response: response)
      question_response.update_attribute(:color_id, color.id)
    end
  end
end

phases = %w(Sales Inception Story\ Writing Estimation Prioritization Delivery Release)

phases.each do |phase_name|
  Phase.find_or_create_by_name(name: phase_name)
end

resource = Resource.find_or_create_by_name({
            user_id: user.id,
            name: 'Awesome Default Resource',
            link: 'www.google.com',
            description: 'This resource will solve all your needs.',
            full_description: 'Well, this resource will go a long way to solving all your needs.',
            source: 'An awesome person',
            tag_list: 'awesome',
            default_image: 'Star-Success.png'
           })
resource.color_ids = [Color.all.first.id]