require_relative ('./bounty_hunter.rb')
require('pry')

BountyHunter.delete_all()

bounty_hunter1 = BountyHunter.new({
  'name' => 'Jonny Alpha',
  'species' => 'Mutant',
  'bounty_value' => '9',
  'favourite_weapon' => 'Blaster'
  })

  bounty_hunter2 = BountyHunter.new({
    'name' => 'Samus Arun',
    'species' => 'Chozo',
    'bounty_value' => '8',
    'favourite_weapon' => 'Cannon'
    })

    bounty_hunter3 = BountyHunter.new({
      'name' => 'Lobo',
      'species' => 'Czarnian',
      'bounty_value' => '10',
      'favourite_weapon' => 'Gun'
      })

      bounty_hunter1.save()
      bounty_hunter2.save()
      bounty_hunter3.save()

      bounty_hunter1.bounty_value = 7

      bounty_hunter1.update()

       # p BountyHunter.find(3)


      binding.pry
      nil
