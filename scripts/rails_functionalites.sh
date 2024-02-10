#!/bin/bash

# Ensure the script stops on first error
set -e

# 1. User Authentication
echo "Setting up User Authentication..."

# Add devise gem to Gemfile
echo "gem 'devise'" >> Gemfile

# Install the gem
bundle install

# Install devise and generate User model
rails generate devise:install
rails generate devise User

# 2. Dataset Upload and Download
echo "Setting up Dataset Upload and Download..."

# Setup ActiveStorage for file uploads
rails active_storage:install

# Generate Dataset model
rails generate model Dataset title:string description:text user:references

# Add file attachment to the model
echo "has_one_attached :file" >> app/models/dataset.rb

# 3. Discussion Forum
echo "Setting up Discussion Forum..."

# Generate models for discussions and comments
rails generate model Discussion title:string content:text user:references
rails generate model Comment content:text user:references discussion:references

# Migrate the database to create tables
rails db:migrate

echo "All done! Please check your application and customize as needed."
