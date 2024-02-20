#!/bin/sh

RAILS_ENV=test bin/rails db:drop db:create db:setup db:seed msip:indices
