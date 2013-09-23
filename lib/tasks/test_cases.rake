task :test_units do
  Rake::Task['test:units'].prerequisites.clear
  Rake::Task['test:units'].invoke
end

task :test_functionals do
  Rake::Task['test:functionals'].prerequisites.clear
  Rake::Task['test:functionals'].invoke
end

task :test_integration do
  Rake::Task['test:integration'].prerequisites.clear
  Rake::Task['test:integration'].invoke
end

namespace :spec_test do
  Rake::TestTask.new(:signin) do |t|
    t.libs << "spec"
    t.pattern = 'spec/features/**/home_spec.rb'
    t.verbose = true
  end
end