import boto
import os
import os.path
import fnmatch
import lxml
import lxml.etree

from optparse import OptionParser
from boto.s3.key import Key
from boto.s3.connection import S3Connection

def progress_report(progress, total):
	print("\r%d%% (%d/%d)" % (int(float(progress) / total * 100), progress, total)),

# Becuase a certain VERY ANNOYING mobile browser (Android) does not support
# client side XSLT transformations - how lame is that - we need to upload a
# pre transformed HTML document.

xml = lxml.etree.parse("resume.xml")
xsl = lxml.etree.parse("resume.xsl")

transform = lxml.etree.XSLT(xsl)
transformed = transform(xml)

html = open("resume_transformed.html", "wt")
html.write(lxml.etree.tostring(transformed))
html.close()

parser = OptionParser()
parser.add_option("-b", "--bucket", dest="bucket", help="The S3 bucket to upload into", action="store")
parser.add_option("-a", "--accesskey", dest="accesskey", help="Your S3 access key", action="store")
parser.add_option("-s", "--secret", dest="secret", help="Your S3 secret key", action="store")

(options, args) = parser.parse_args()

if options.bucket is None:
	parser.error("You need to specify a --bucket option")

if options.accesskey is None:
	parser.error("You need to specify a --accesskey option")

if options.secret is None:
	parser.error("You need to specify an --secret option")

conn = S3Connection(options.accesskey, options.secret)
bucket = conn.create_bucket(options.bucket)

files = [
	"resume.xml",
	"resume.xsl",
	"resume.css",
	"resume.html",
	"resume_transformed.html",
]

for file in os.listdir("."):
	if fnmatch.fnmatch(file, '*.jpg'):
		files.append(file)

for file in files:
	print file
	
	key = Key(bucket)
	key.key = file
	key.set_contents_from_filename(file, cb=progress_report, num_cb=1000)
	key.set_acl("public-read")
	
	print ""


