# ref:
# - https://docs.python.org/3/library/readline.html?highlight=readline#example
# - https://bugs.python.org/msg318437
# - https://unix.stackexchange.com/a/704612
import atexit
import os
import readline
import time

if 'PYTHONHISTFILE' in os.environ:
    histfile = os.path.expanduser(os.environ['PYTHONHISTFILE'])
else:
    histfile = os.path.join(os.path.expanduser("~"), ".python_history")

try:
    readline.read_history_file(histfile)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, 'wb').close()
    h_len = 0

# prevent creation of default history if custom is empty
if readline.get_current_history_length() == 0:
    readline.add_history(f'# History file created at {time.asctime()}')

def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)

atexit.register(save, h_len, histfile)
