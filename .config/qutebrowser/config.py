# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
#   qute://help/settings.html#bindings.commands (brief mode explanation)
#   qute://help/commands.html

# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# Change the argument to True to still load settings configured
# via autoconfig.yml
config.load_autoconfig(False)

# Load redirectors.py script
config.source('pyconfig/redirectors.py')

c.changelog_after_upgrade = 'minor'

c.colors.hints.bg = 'black'
c.colors.hints.fg = 'white'
c.colors.hints.match.fg = 'lightgreen'
c.colors.webpage.bg = 'black'
c.colors.webpage.preferred_color_scheme = 'dark'

c.completion.height = '20%'
c.completion.open_categories = [
    'searchengines',
    'quickmarks',
    'bookmarks',
    'history',
    'filesystem',
]
c.completion.shrink = False
c.completion.web_history.exclude = [
    'file://*/.config/qutebrowser/index.html',
    'about:blank',
    'qute://start',
]

c.confirm_quit = ['downloads']

c.content.autoplay = False
c.content.blocking.enabled = True
c.content.blocking.method = 'auto'
c.content.cookies.accept = 'all'
c.content.desktop_capture = 'ask'
c.content.geolocation = False
c.content.headers.do_not_track = True
c.content.images = True
c.content.javascript.clipboard = 'access'
c.content.javascript.enabled = True
c.content.media.audio_capture = 'ask'
c.content.media.audio_video_capture = 'ask'
c.content.media.video_capture = 'ask'
c.content.notifications.enabled = 'ask'
c.content.notifications.presenter = 'auto'
c.content.pdfjs = False
c.content.private_browsing = False

c.downloads.location.remember = False
c.downloads.position = 'bottom'
c.downloads.location.directory = '/home/bruhtus/downloads/'

c.fonts.default_family = []
c.fonts.default_size = '11pt'
c.fonts.hints = 'default_size default_family'

c.hints.uppercase = True
c.hints.leave_on_load = True

c.input.match_counts = False
c.scrolling.bar = 'never'

c.statusbar.widgets = [
    'keypress',
    'search_match',
    'history',
    'url',
    'progress',
    'tabs',
    'scroll',
]

c.tabs.show = 'never'
c.tabs.select_on_remove = 'last-used'
c.tabs.wrap = True

c.url.default_page = 'qute://start'
c.url.searchengines = {
    'DEFAULT': 'https://opnxng.com/search?q={}',
    '!g': 'https://google.com/search?q={}',
}
c.url.start_pages = 'qute://start'
c.url.yank_ignored_parameters = [
    'ref',
    'utm_source',
    'utm_medium',
    'utm_campaign',
    'utm_term',
    'utm_content',
    'utm_name',
]

c.bindings.default = {}

# Bindings for normal mode
config.bind(':', 'cmd-set-text :')
config.bind('.', 'cmd-repeat-last')
config.bind('/', 'cmd-set-text /')
config.bind('?', 'cmd-set-text ?')
config.bind(',j', 'config-cycle -u *://*.{url:host}/* colors.webpage.darkmode.enabled True False ;; reload')
config.bind(',k', 'config-cycle colors.webpage.bg white black')
config.bind(',m', 'hint links spawn youtube-viewer --resolution=480p {hint-url}')
config.bind(',c', 'hint links spawn -d google-chrome-stable --incognito {hint-url}')
config.bind(',C', 'spawn -d google-chrome-stable --incognito {url}')
config.bind('<Ctrl-=>', 'zoom-in')
config.bind('<Ctrl-->', 'zoom-out')
config.bind('<Ctrl-0>', 'zoom')
config.bind('<Ctrl-S>', 'tab-focus last')
config.bind('<Ctrl-N>', 'open -w')
config.bind('<Ctrl-Shift-N>', 'open -p')
config.bind('<Escape>', 'clear-keychain ;; search ;; stop')
config.bind('<F11>', 'fullscreen')
config.bind('<F12>', 'devtools bottom')
config.bind('<F5>', 'reload')
config.bind('<Space>', 'nop')
config.bind('<Return>', 'selection-follow')
config.bind('F', 'hint all tab')
config.bind('G', 'scroll-to-perc')
config.bind('H', 'back')
config.bind('I', 'mode-enter passthrough')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('L', 'forward')
config.bind('N', 'search-prev')
config.bind('O', 'cmd-set-text -s :open -t')
config.bind('P', 'open -t -- {clipboard}')
config.bind('Q', 'cmd-set-text -s :session-load')
config.bind('R', 'reload -f')
config.bind('X', 'undo')
config.bind('ZX', 'cmd-set-text -s :session-save --only-active-window')
config.bind('ZQ', 'close')
# Note: the downside of this approach is that, we can only save and close one
# one session. if we have two session opened, this mapping will screw up our session.
# Ref: https://github.com/qutebrowser/qutebrowser/issues/572
# config.bind('ZZ', 'cmd-set-text session-save --only-active-window;; cmd-set-text --append close')
config.bind('ZZ', 'session-save --current --only-active-window;; close')
config.bind('[[', 'navigate prev')
config.bind(']]', 'navigate next')
config.bind('ad', 'download-cancel')
config.bind('cd', 'download-clear')
config.bind('cn', 'hint inputs')
config.bind('cw', 'cmd-set-text :open {url:pretty}')
config.bind('cW', 'cmd-set-text :open -t -r {url:pretty}')
config.bind('cb', 'cmd-set-text -s :open -b')
config.bind('cB', 'cmd-set-text :open -b -r {url:pretty}')
config.bind('d', 'scroll-page 0 0.5')
config.bind('f', 'hint')
config.bind('gg', 'scroll-to-perc 0')
config.bind('gi', 'hint inputs --first')
config.bind('gt', 'cmd-set-text -s :tab-give')
config.bind('gf', 'hint all tab-fg')
config.bind('h', 'scroll left')
config.bind('i', 'mode-enter insert')
config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
config.bind('l', 'scroll right')
config.bind('n', 'search-next')
config.bind('o', 'cmd-set-text -s :open')
config.bind('r', 'reload')
config.bind('t', 'cmd-set-text -sr :tab-focus --no-last')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('v', 'mode-enter caret')
config.bind('x', 'tab-close')
config.bind('yf', 'hint links yank')
config.bind('yy', 'yank')
config.bind('yt', 'tab-clone')

# Bindings for insert mode
config.bind('<Escape>', 'mode-leave', mode='insert')
config.bind('<Shift-Escape>', 'mode-enter passthrough', mode='insert')
config.bind('<Ctrl-H>', 'fake-key <Backspace>', mode='insert')
config.bind('<Ctrl-M>', 'fake-key <Enter>', mode='insert')
config.bind('<Ctrl-I>', 'fake-key <Tab>', mode='insert')
config.bind('<Ctrl-A>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-E>', 'fake-key <End>', mode='insert')
config.bind('<Ctrl-B>', 'fake-key <Left>', mode='insert')
config.bind('<Ctrl-F>', 'fake-key <Right>', mode='insert')
config.bind('<Ctrl-P>', 'fake-key <Up>', mode='insert')
config.bind('<Ctrl-N>', 'fake-key <Down>', mode='insert')
config.bind('<Ctrl-D>', 'fake-key <Delete>', mode='insert')
config.bind('<Ctrl-W>', 'fake-key <Ctrl-Backspace>', mode='insert')
config.bind('<Ctrl-U>', 'fake-key <Shift-Home><Delete>', mode='insert')
config.bind('<Ctrl-K>', 'fake-key <Shift-End><Delete>', mode='insert')

# Bindings for command mode
config.bind('<Ctrl-Alt-H>', 'rl-backward-kill-word', mode='command')
config.bind('<Alt-D>', 'rl-kill-word', mode='command')
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='command')
config.bind('<Ctrl-B>', 'rl-backward-char', mode='command')
config.bind('<Alt-B>', 'rl-backward-word', mode='command')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='command')
config.bind('<Ctrl-F>', 'rl-forward-char', mode='command')
config.bind('<Alt-F>', 'rl-forward-word', mode='command')
config.bind('<Ctrl-H>', 'rl-backward-delete-char', mode='command')
config.bind('<Ctrl-K>', 'rl-kill-line', mode='command')
config.bind('<Ctrl-N>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-P>', 'completion-item-focus prev', mode='command')
config.bind('<Ctrl-U>', 'rl-unix-line-discard', mode='command')
config.bind('<Ctrl-W>', 'rl-rubout " "', mode='command')
config.bind('<Return>', 'command-accept', mode='command')
config.bind('<Escape>', 'mode-leave', mode='command')
config.bind('<Ctrl-C>', 'mode-leave', mode='command')
config.bind('<Down>', 'completion-item-focus --history next', mode='command')
config.bind('<Up>', 'completion-item-focus --history prev', mode='command')

## Bindings for caret mode
config.bind('$', 'move-to-end-of-line', mode='caret')
config.bind('0', 'move-to-start-of-line', mode='caret')
config.bind('<Escape>', 'mode-leave', mode='caret')
config.bind('<Ctrl-C>', 'mode-leave', mode='caret')
config.bind('<Return>', 'yank selection', mode='caret')
config.bind('<Space>', 'selection-toggle', mode='caret')
config.bind('G', 'move-to-end-of-document', mode='caret')
config.bind('H', 'scroll left', mode='caret')
config.bind('J', 'scroll down', mode='caret')
config.bind('K', 'scroll up', mode='caret')
config.bind('L', 'scroll right', mode='caret')
config.bind('V', 'selection-toggle --line', mode='caret')
config.bind('[', 'move-to-start-of-prev-block', mode='caret')
config.bind(']', 'move-to-start-of-next-block', mode='caret')
config.bind('b', 'move-to-prev-word', mode='caret')
config.bind('c', 'mode-enter normal', mode='caret')
config.bind('e', 'move-to-end-of-word', mode='caret')
config.bind('g_', 'move-to-end-of-line', mode='caret')
config.bind('gg', 'move-to-start-of-document', mode='caret')
config.bind('h', 'move-to-prev-char', mode='caret')
config.bind('j', 'move-to-next-line', mode='caret')
config.bind('k', 'move-to-prev-line', mode='caret')
config.bind('l', 'move-to-next-char', mode='caret')
config.bind('o', 'selection-reverse', mode='caret')
config.bind('w', 'move-to-next-word', mode='caret')
config.bind('y', 'yank selection', mode='caret')
config.bind('{', 'move-to-end-of-prev-block', mode='caret')
config.bind('}', 'move-to-end-of-next-block', mode='caret')

## Bindings for hint mode
config.bind('<Escape>', 'mode-leave', mode='hint')
config.bind('<Ctrl-C>', 'mode-leave', mode='hint')

## Bindings for passthrough mode
config.bind('<Shift-Escape>', 'mode-leave', mode='passthrough')

## Bindings for prompt mode
config.bind('<Ctrl-Alt-H>', 'rl-backward-kill-word', mode='prompt')
config.bind('<Ctrl-Shift-Y>', 'prompt-yank --sel', mode='prompt')
config.bind('<Ctrl-Y>', 'prompt-yank', mode='prompt')
config.bind('<Ctrl-A>', 'rl-beginning-of-line', mode='prompt')
config.bind('<Ctrl-B>', 'rl-backward-char', mode='prompt')
config.bind('<Ctrl-E>', 'rl-end-of-line', mode='prompt')
config.bind('<Ctrl-F>', 'rl-forward-char', mode='prompt')
config.bind('<Ctrl-H>', 'rl-backward-delete-char', mode='prompt')
config.bind('<Ctrl-K>', 'rl-kill-line', mode='prompt')
config.bind('<Ctrl-Shift-W>', 'rl-filename-rubout', mode='prompt')
config.bind('<Ctrl-U>', 'rl-unix-line-discard', mode='prompt')
config.bind('<Ctrl-W>', 'rl-rubout " "', mode='prompt')
config.bind('<Ctrl-X>', 'prompt-open-download', mode='prompt')
config.bind('<Down>', 'prompt-item-focus next', mode='prompt')
config.bind('<Escape>', 'mode-leave', mode='prompt')
config.bind('<Ctrl-C>', 'mode-leave', mode='prompt')
config.bind('<Return>', 'prompt-accept', mode='prompt')
config.bind('<Ctrl-P>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Ctrl-N>', 'prompt-item-focus next', mode='prompt')
config.bind('<Up>', 'prompt-item-focus prev', mode='prompt')

## Bindings for register mode
config.bind('<Escape>', 'mode-leave', mode='register')
config.bind('<Ctrl-c>', 'mode-leave', mode='register')

## Bindings for yesno mode
config.bind('<Ctrl-Shift-Y>', 'prompt-yank --sel', mode='yesno')
config.bind('<Ctrl-Y>', 'prompt-yank', mode='yesno')
config.bind('<Escape>', 'mode-leave', mode='yesno')
config.bind('<Ctrl-c>', 'mode-leave', mode='yesno')
config.bind('<Return>', 'prompt-accept', mode='yesno')
config.bind('N', 'prompt-accept --save no', mode='yesno')
config.bind('Y', 'prompt-accept --save yes', mode='yesno')
config.bind('n', 'prompt-accept no', mode='yesno')
config.bind('y', 'prompt-accept yes', mode='yesno')
