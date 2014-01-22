admin = User.new
admin.update_attributes({name: 'Default Admin', email: 'admin@example.com', password: '0000', password_confirmation: '0000', is_admin: true})
user = User.new
user.update_attributes({name: 'Default User', email: 'test@example.com', password: '0000', password_confirmation: '0000', is_admin: false})

blue_proposition = [
  'Traditional TW IT Delivery',
  'This client has ambitious ideas and will rely on us to deliver high quality, technically advanced systems on time and in budget.  Our top deliverables are technical prowess, agile leadership, and continuous quality.',
  'visionary.png']

green_proposition = [
  'Fast IT Delivery',
  'green description',
  'adventurer.png']

yellow_proposition = [
  'Rapid Incremental Innovation',
  'This established client cares about creativity and speed to hold the lead in a cut throat market: it\'s about out-innovating the competitors.  Our top deliverables are insights, tools, and speed.',
  'analyst.png']

orange_proposition = [
  'Disruptive Greenfield Innovation',
  'This client is likely at the beginning of an exciting new business venture; their problem is radical re-invention of unproven game changing markets.  Our top deliverables are disruptive vision, lean product learning, and iterative pivots.',
  'enterpriser.png']

red_proposition = [
  'Complex System Innovation',
  'This client is looking for big picture solutions and a full lifecycle execution. Our top deliverables are program vision, integrated solutions, and service design.',
  'anchor.png']

copper_proposition = [
  'Agile IT',
  'copper description',
  'team_player.png']

silver_proposition = [
  'Full Product Lifecycle Agile',
  'This client wants innovation capable organizers who work with speed, business engagement, and flexibility.  Our top deliverables are agile process design, side by side delivery, and tools & training.',
  'straightliner.png'
]

gold_proposition = [
  'Enterprise Agile',
  'gold description',
  'zigzagger.png'
]

value_proposition_categories = [
    ['Technical Value Proposition Categories', [blue_proposition, green_proposition], 'Technical Value Proposition Categories Description'],
    ['Business Innovation Value Proposition Categories', [yellow_proposition, orange_proposition, red_proposition], 'Business Innovation Value Proposition Categories Description'],
    ['Process Innovation Propositions', [copper_proposition, silver_proposition, gold_proposition], 'Process Innovation Propositions Description']
]

value_proposition_categories.each do |name, color_propositions, value_proposition_category_description|
  value_proposition_category = ValuePropositionCategory.find_or_create_by(name: name, description: value_proposition_category_description)
  color_propositions.each do |name, color_description, image, question_responses|
    color = value_proposition_category.colors.find_or_create_by_name(name: name, description: color_description, default_image: image)
  end
end

resource = Resource.find_or_create_by({
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