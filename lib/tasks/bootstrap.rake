namespace :bootstrap do
  
  desc "drops the database out of the given environment in preparation for bootstrapping"
  task :trash => :environment do
    environment = rake_param('RAILS_ENV') || 'development'
    unless environment == 'production'
      puts "chucking #{environment} database..."
      system "mysqladmin --user root --force drop zhook_#{environment}"
      puts "done trashing."
    end
  end
  
  desc "unzips the bootstrap tarball and restores the various files"
  task :setup => :environment do
    environment = rake_param('RAILS_ENV') || 'development'
    puts "copying the compressed bootstrap database.."
    system "cp ../assets/bootstrap.sql.gz tmp/"
    puts "extracting.."
    system "gunzip tmp/bootstrap.sql.gz"
    puts "creating #{environment} database..."
    system "mysqladmin --user root create zhook_#{environment}"
    puts "importing data..."
    system "mysql -u root zhook_#{environment} < tmp/bootstrap.sql"
    puts "cleaning up files..."
    system "rm tmp/bootstrap.sql"
    puts "done."
  end
  
  desc "creates gzip of the database for later use in bootstrapping"
  task :backup => :environment do
    environment = rake_param('RAILS_ENV') || 'development'
    filename = "../assets/bootstrap.sql"
    unless environment == 'production'
      puts "backing up #{environment} database..."
      system "mysqldump -uroot zhook_#{environment} > #{filename}"
      system "gzip #{filename}"
      puts "done."
    end
  end
  
  task :test => :environment do
    test = system "stat loser/"  
    puts test
  end
  
end

def rake_param(param_name)
  if !ENV.include?(param_name) || ENV[param_name].blank?
    puts "No '#{param_name}' specified!"
    nil
  else
    ENV[param_name]
  end
end

def optional_rake_param(param_name)
  if !ENV.include?(param_name) || ENV[param_name].blank?
    nil
  else
    ENV[param_name]
  end
end