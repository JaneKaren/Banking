namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Account, Move, MoveType, Ownership, User].each(&:delete_all)

    User.populate 5 do |user|
      user.username = Faker::Name.name
      user.email = Faker::Internet.email
      user.password_hash = '$2a$10$AGIe4wML3bDQ6QHBS8dfQ.vvWhGYCoPLAaNsG6LmH9MQJ5RSe8QG6' # 1234
      user.password_salt = '$2a$10$AGIe4wML3bDQ6QHBS8dfQ.'
      user.admin = [true, false]
      Account.populate 5 do |account|
        account.name = Populator.words(2).titleize
        Ownership.populate 1 do |own|
          own.user_id = user.id
          own.account_id = account.id
        end
        MoveType.populate 8 do |mt|
          mt.name = Populator.words(2).titleize
          mt.account_id = account.id
          mt.income = [true, false]
          Move.populate 10 do |move|
            move.user_id = user.id
            move.account_id = account.id
            move.move_type_id = mt.id
            move.amount = 1..1000
            move.date = 2.years.ago..Time.now
            move.notice = Populator.words(2..10)
          end
        end
      end
    end


  end
end