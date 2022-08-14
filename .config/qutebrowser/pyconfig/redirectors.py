import operator, re, typing
from urllib.parse import urljoin

from qutebrowser.api import interceptor, message
from PyQt5.QtCore import QUrl


def _debian_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if p.isdigit():
		url.setPath(urljoin("/plain/", p))
		return True
	return False

def _the_compiler_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	res = re.search(r"\w+$", p)
	if p.startswith('view/') and res:
		url.setPath(urljoin("/view/raw/", res.group()))
		return True
	return False

def _pastebin_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if p.isalnum():
		url.setPath(urljoin("/raw/", p))
		return True
	return False

def _hastebin_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if "raw" not in p:
		url.setPath(urljoin("/raw/", p))
		return True
	return False


# Any return value other than a literal 'False' means we redirected
REDIRECT_MAP = {
	"reddit.com": operator.methodcaller('setHost', 'teddit.net'),
	"old.reddit.com": operator.methodcaller('setHost', 'teddit.net'),
	"www.reddit.com": operator.methodcaller('setHost', 'teddit.net'),

	# Pastebins
	"paste.debian.net": _debian_redir,
	"paste.the-compiler.org": _the_compiler_redir,
	# Causes an infinite loop if the paste does not exist...
	"pastebin.com": _pastebin_redir,
	"hasteb.in": _hastebin_redir,
	"hastebin.com": _hastebin_redir,
} # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]

def int_fn(info: interceptor.Request):
	"""Block the given request if necessary."""
	if (info.resource_type != interceptor.ResourceType.main_frame or
			info.request_url.scheme() in {"data", "blob"}):
		return
	url = info.request_url
	redir = REDIRECT_MAP.get(url.host())
	if redir is not None and redir(url) is not False:
		message.info("Redirecting to " + url.toString())
		info.redirect(url)


interceptor.register(int_fn)
