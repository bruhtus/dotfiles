import os

os.chdir('all_git')
dir_list = [dirname for dirname in os.listdir(os.getcwd()) if os.path.isdir(dirname) == True]

for dirname in dir_list:
    os.chdir(dirname)
    print(f"\033[1m{dirname}\033[0m")

    if os.path.exists('.gitmodules') == True:
        os.system('git status')
        print('\t')
        os.system('git submodule foreach git status')
    else:
        os.system('git status')

    print('done\n')
    os.chdir('../')
