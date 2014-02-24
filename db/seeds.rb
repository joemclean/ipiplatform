admin = User.new
admin.update_attributes({name: 'Default Admin', email: 'admin@example.com', password: '0000', password_confirmation: '0000', is_admin: true})
@user = User.new
@user.update_attributes({name: 'Default User', email: 'test@example.com', password: '0000', password_confirmation: '0000', is_admin: false})

def new_resource(resource_name)
  Resource.new(name: resource_name, link: "https://www.wikipedia.com", description: "Some description", full_description: "Full Description", source: "A user", user_id: @user.id )
end


blue_steps = [['Inception', new_resource('Awesome Resource')]]
blue_proposition = [
  'Traditional TW IT Delivery',
  'This client has ambitious ideas and will rely on us to deliver high quality, technically advanced systems on time and in budget.  Our top deliverables are technical prowess, agile leadership, and continuous quality.',
  'visionary.png',
  blue_steps]

green_proposition = [
  'Fast IT Delivery',
  'green description',
  'adventurer.png']

yellow_proposition = [
  'Continuous Innovation',
  'This established client cares about creativity and speed to hold the lead in a cut throat market: it\'s about out-innovating the competitors.  Our top deliverables are insights, tools, and speed.',
  'analyst.png']

orange_steps = [['Sales', [new_resource('How to Create a Successful Story')]],['Proposal',[new_resource('Powerfull Presentation'),new_resource('5 Ways to Influence Clients')]],
                 ['Visioning Workshop'], ['Research Sprint'], ['MVP Workshop'], ['Build/Refine'], ['Pivots'], ['Hand-off',[new_resource('Entity Relationship Diagram')]]
                ]

orange_proposition = [
  'New Product  Innovation',
  'This client is likely at the beginning of an exciting new business venture; their problem is radical re-invention of unproven game changing markets.  Our top deliverables are disruptive vision, lean product learning, and iterative pivots.',
  'enterpriser.png',
  orange_steps
]



red_proposition = [
  'Enterprise Innovation',
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
  ['Technical Value Propositions', [blue_proposition, green_proposition], 'Technical Value Proposition Categories Description'],
  ['Business Innovation Value Propositions', [yellow_proposition, orange_proposition, red_proposition], 'Business Innovation Value Proposition Categories Description'],
  ['Process Innovation Propositions', [copper_proposition, silver_proposition, gold_proposition], 'Process Innovation Propositions Description']
]

value_proposition_categories.each do |name, value_proposition, value_proposition_category_description|
  value_proposition_category = ValuePropositionCategory.find_or_create_by(name: name, description: value_proposition_category_description)
  value_proposition.each do |vp_name, value_proposition_description, image, steps|
    value_proposition = value_proposition_category.value_propositions.find_or_create_by_name(name: vp_name, description: value_proposition_description, default_image: image)
      Array(steps).each do |step_name, resources|
        created_step = Step.find_or_create_by(name: step_name, value_proposition_id: value_proposition.id)
        Array(resources).each do |resource|
          resource.step_id = created_step.id
          resource.save
        end
      end
  end
end
