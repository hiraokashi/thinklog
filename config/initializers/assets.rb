# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(libs/modernizr.custom.js libs/jquery-1.11.2.min.js libs/jquery.easing.1.3.js plugins/bootstrap.min.js plugins/jquery.touchSwipe.min.js   plugins/jquery.placeholder.js plugins/icheck.min.js plugins/jquery.validate.min.js plugins/gallery.js plugins/jquery.fitvids.js plugins/jquery.bxslider.min.js plugins/chart.js plugins/waypoints.min.js plugins/smoothscroll.js)
