pod repo add RSUtils https://github.com/mhtranbn/RSUtils.git
pod repo push RSUtils RSUtils.podspec --allow-warnings
pod lib lint --allow-warnings
pod repo update
pod trunk push RSUtils.podspec --allow-warnings

