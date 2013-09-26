# config/initializers/simple_roles.rb
SimpleRoles.configure do
  valid_roles :company_administrator, :admin
  strategy :many # Default is :one
end