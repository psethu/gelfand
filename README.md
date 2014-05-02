#Gelfand Center Application
This application helps the Leonard Gelfand Center at Carnegie Mellon University manage and keep track of background checks. 
## Running Locally

Install git on your machine and clone the repository:
```console
git clone https://github.com/sankalpk/gelfand.git
```

Make sure Rails 4 and Ruby 2.1 are setup on your computer. Run the following from the terminal:
```console
bundle install        # downloads any necessary gems
rake db:migrate       # creates the database and all its tables
rails server          # starts the server
```

Congratulations. The application is running. Point your web browser to http://localhost:3000.

## Deploying to OpenShift
Install the gem and setup your machine. Follow instructions from the console:
```console
gem install rhc
rhc setup
```

Now it's time to create the application on OpenShift. Make sure gem pg is in the Gemfile and run:
```console
rhc app create gelfand ruby-1.9 postgresql-9.2 --from-code=https://github.com/sankalpk/gelfand.git
```
The application is now hosted. We need to tell our git repository where to push code. Run the following and copy the git URL:

```console
rhc app show openshift 
```
Run the following to add OpenShift:
```console
git remote add openshift ssh:/3234543534@appname-appsubdomain.rhcloud.com/~/git/openshiftapp.git/
git push -f --set-upstream openshift master
```

Now you can push and deploy code with one easy command:
```console
git push openshift master
```
These notes were borrowed and summarized from various sources. Definitely check out the [Rails Girls Guide](http://guides.railsgirls.com/openshift/), the [OpenShift Blog](https://www.openshift.com/blogs/openshift-is-a-rails-friendly-paas-part-1), and [A Ruby Story Blog](http://arubystory.blogspot.com/2013/12/tutorial-todo-rails-openshift.html) for further help.

## Maintaining OpenShift

To view production logs run:
```console
rhc tail gelfand
```

To SSH into the server run:
```console
rhc ssh todo
```
Once you're connected to the server, you can access your code directory by running the following:
```console
cd app-root/repo
```
To update the database with new migrations first SSH into the server, go to the app root and then run:
```console
bundle exec rake db:migrate RAILS_ENV="production"
```
