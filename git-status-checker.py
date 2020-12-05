import os

os.chdir(os.path.expanduser('~/all_git'))
dir_list = [dirname for dirname in os.listdir(os.getcwd()) if os.path.isdir(dirname) == True]

for dirname in dir_list:
    os.chdir(dirname)
    #print(f"\033[1m{dirname}\033[0m") #bold text in terminal
    #os.system(f"echo -e '\033[1m{dirname}\033[0m'") #another approach
    os.system('pwd')

    if os.path.exists('.gitmodules') == True:
        os.system('git status -s')
        #print('\t')
        os.system('git submodule foreach git status -s')
    else:
        os.system('git status -s')

    #print('done\n')
    os.chdir('../')

os.chdir('../')
os.system('pwd')
os.system('dotbare status -s')
