git remote add origin https://github.com/mhtranbn/RSUtils.git
git push -u origin master --tags
pod repo add RSUtils https://github.com/mhtranbn/RSUtils.git
pod repo push RSUtils RSUtils.podspec --allow-warnings
pod lib lint --allow-warnings
pod repo update
pod trunk register hoangtm@runsystem.net 'hoangtm' --description='macbook pro'
pod trunk push RSUtils.podspec --allow-warnings --verbose
