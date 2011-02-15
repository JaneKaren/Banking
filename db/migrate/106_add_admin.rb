class AddAdmin < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `password_salt`, `admin`) VALUES (1, 'JaneKaren', 'janekaren@soukroma.cz', '$2a$10$AGIe4wML3bDQ6QHBS8dfQ.vvWhGYCoPLAaNsG6LmH9MQJ5RSe8QG6', '$2a$10$AGIe4wML3bDQ6QHBS8dfQ.', 1);"
  end

  def self.down
    execute "DELETE FROM users WHERE id = 1"
  end
end
