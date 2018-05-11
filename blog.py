#blog.py
import sys
from flask import Flask, render_template
from flask_flatpages import FlatPages, pygments_style_defs
from flask_frozen import Freezer

DEBUG=True
FLATPAGES_AUTO_RELOAD=DEBUG
FLATPAGES_EXTENSION='.md'
FLATPAGES_ROOT='content'
POST_DIR='posts'

app=Flask(__name__)
flatpages=FlatPages(app)
freezer = Freezer(app)
app.config['FREEZER_DESTINATION']=''
app.config['FREEZER_DESTINATION_IGNORE']=['.git*','blog.py','content/posts/*.md','templates/*.html','templates/*.css','sources']



app.config.from_object(__name__)

@app.route("/")
def posts_1():
    posts=[p for p in flatpages if p.path.startswith(POST_DIR)]
    posts.sort(key=lambda item:item['date'], reverse=False)
    return render_template('posts.html',posts=posts)

@app.route("/posts/")
def posts():
    posts=[p for p in flatpages if p.path.startswith(POST_DIR)]
    posts.sort(key=lambda item:item['date'], reverse=False)
    return render_template('posts.html',posts=posts)

@app.route('/posts/<name>/')
def post(name):
    path='{}/{}'.format(POST_DIR,name)
    post=flatpages.get_or_404(path)
    return render_template('post.html',post=post)



if __name__=="__main__":
    if len(sys.argv)>1 and sys.argv[1]=="build":
        freezer.freeze()
    else:
        app.run(host='0.0.0.0',debug=True)
