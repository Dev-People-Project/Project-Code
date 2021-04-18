# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

from app.home import blueprint
from flask import render_template, redirect, url_for, request
from flask_login import login_required, current_user
from app import login_manager
from jinja2 import TemplateNotFound
import pymysql




config = {
    'host': '127.0.0.1',
    'port': 13306,
    'user': 'root',
    'database': 'mydb'
}


@blueprint.route('/jaesung_festivalList')
@login_required
def index():

    db = pymysql.connect(**config)
    cur = db.cursor()
    sql = "SELECT * from festival"
    cur.execute(sql)

    data_list = cur.fetchall()
    
    return render_template('jaesung_festivalList.html', segment='index', data_list=data_list)


@blueprint.route('/jan_festival')
@login_required
def index2():

    db = pymysql.connect(**config)
    cur = db.cursor()
    sql = "SELECT * from festival"
    cur.execute(sql)

    data_list = cur.fetchall()
    
    return render_template('jan_festival.html', segment='index2', data_list=data_list)


@blueprint.route('/juthor_dash')
@login_required
def index3():

    db = pymysql.connect(**config)
    cur = db.cursor()
    sql = "SELECT * from festival"
    cur.execute(sql)

    data_list = cur.fetchall()
    
    return render_template('juthor_dash.html', segment='index3', data_list=data_list)


@blueprint.route('/juthor_category')
@login_required
def category():
    db = pymysql.connect(host="localhost", user="root", password="mysql",
                        db="mydb", charset="utf8")
    cur = db.cursor()
    sql = '''select unique category, count(category) as '가게 수'
             from store
             group by category'''
    cur.execute(sql)

    data_list = cur.fetchall()
    return render_template('juthor_category.html', segment='category', data_list=data_list)


@blueprint.route('/juthor_storelist')
@login_required
def storelist():
    db = pymysql.connect(host="localhost", user="root", password="mysql",
                        db="mydb", charset="utf8")
    cur = db.cursor()
    sql = '''select store_name, store_description, location_number
             from store
             where category="치킨"'''
    cur.execute(sql)

    data_list = cur.fetchall()
    return render_template('juthor_storeList.html', segment='storelist', data_list=data_list)


@blueprint.route('/juthor_cart')
@login_required
def cart():
    data_list=get_menu()
    return render_template('juthor_cart.html', segment='cart', data_list=data_list)

def get_menu():
    db = pymysql.connect(host="localhost", user="root", password="mysql",
                        db="mydb", charset="utf8")
    
    cur = db.cursor()
    sql = '''
        select menu_name, menu_price
        from menu
        where store_id=3''' 

    cur.execute(sql)
    data_list = cur.fetchall()
    return data_list

# @blueprint.route('/juthor_cart/insert', methods=['POST'])
# @login_required
# def insert() :
#     element = request.values.get('insert')
#     element = request.form.getlist('menu')
#     print(element)
#     cart_insert(element)
#     # return render_template('juthor_cart.html', segment='cart')
#     return '''
#             <script>
#                 alert("저장되었습니다")
#                 location.href="."
#             </script>
#            ''' 

@blueprint.route('/<template>')
@login_required
def route_template(template):

    try:

        if not template.endswith( '.html' ):
            template += '.html'

        # Detect the current page
        segment = get_segment( request )

        # Serve the file (if exists) from app/templates/FILE.html
        return render_template( template, segment=segment )

    except TemplateNotFound:
        return render_template('page-404.html'), 404
    
    except:
        return render_template('page-500.html'), 500

# Helper - Extract current page name from request 
def get_segment( request ): 

    try:

        segment = request.path.split('/')[-1]

        if segment == '':
            segment = 'index'

        return segment    

    except:
        return None  
