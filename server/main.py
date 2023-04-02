from flask import Flask, jsonify, request
import pymysql
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


# การเชื่อมต่อฐานข้อมูล
db = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'Geo',
    'cursorclass': pymysql.cursors.DictCursor
}

# สร้าง connection
mysql = pymysql.connect(**db)

# Get all rooms
@app.route('/room', methods=['GET'])
def get_rooms():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Room")
    rows = cur.fetchall()
    cur.close()
    return jsonify(rows)

# Get a single room
@app.route('/room/<int:id>', methods=['GET'])
def get_room(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Room WHERE R_ID=%s", [id])
    row = cur.fetchone()
    cur.close()
    return jsonify(row)

# Create a new room
@app.route('/room', methods=['POST'])
def add_room():
    mysql = pymysql.connect(**db)
    data = request.get_json()
    r_description = data['R_Description']
    images = data['Images']
    r_owner = data['R_Owner']
    r_name = data['R_Name']
    r_status = 1
    r_type = data['R_Type']
    mute = 0
    visible = 1
    r_tell = data['R_Tell']
    r_detail = data['R_Detail']
    province = data['Province']

    cur = mysql.cursor()
    sql = "INSERT INTO `Room` (`R_Description`, `Images`, `R_Owner`, `R_Name`, `R_Status`, `R_Type`, `Mute`, `Visible`, `R_Tell`, `R_Detail`, `Province`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    cur.execute(sql,
                (r_description, images, r_owner, r_name, r_status, r_type, mute, visible, r_tell, r_detail, province))
    mysql.commit()

    # result = {
    #     'R_ID': cur.lastrowid,
    #     'R_Description': r_description,
    #     'Images': images,
    #     'R_Owner': r_owner,
    #     'R_Name': r_name,
    #     'R_Status': r_status,
    #     'R_Type': r_type,
    #     'Mute': mute,
    #     'Visible': visible,
    #     'R_Tell': r_tell,
    #     'R_Detail': r_detail,
    #     'Province': province
    # }

    # return jsonify(result)

    return jsonify({"message": "New room created."})

# Update a room
@app.route('/room/<int:id>', methods=['PUT'])
def update_room(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    r_name = request.json['R_Name']
    r_detail = request.json['R_Detail']
    cur.execute("UPDATE Room SET R_Name=%s, R_Detail=%s WHERE R_ID=%s", (r_name, r_detail, id))
    mysql.commit()
    cur.close()
    return jsonify({"message": "Room updated."})

# Delete a room
@app.route('/room/<int:id>', methods=['DELETE'])
def delete_room(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM Room WHERE R_ID=%s", [id])
    mysql.commit()
    cur.close()
    return jsonify({"message": "Room deleted."})


# Get all room members
@app.route('/room_members', methods=['GET'])
def get_all_room_members():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Room_Member")
    rv = cur.fetchall()
    cur.close()
    return jsonify(rv)


# Get a single room member
@app.route('/room_members/<int:id>', methods=['GET'])
def get_room_member(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Room_Member WHERE R_ID=%s", (id,))
    rv = cur.fetchall()
    cur.close()
    return jsonify(rv)


# Add a new room member
@app.route('/room_members', methods=['POST'])
def add_room_member():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    r_id = request.json['R_ID']
    user_member = request.json['User_Member']
    r_class = request.json['R_Class']
    status = request.json['Status']
    room_blacklist = request.json['Room_BlackList']
    cur.execute("INSERT INTO Room_Member(R_ID, User_Member, R_Class, Status, Room_BlackList) VALUES(%s, %s, %s, %s, %s)", (r_id, user_member, r_class, status, room_blacklist))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'New room member added!'})


# Update an existing room member
@app.route('/room_members/<int:id>', methods=['PUT'])
def update_room_member(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    r_id = request.json['r_id']
    user_member = request.json['user_member']
    r_class = request.json['r_class']
    status = request.json['status']
    room_blacklist = request.json['room_blacklist']
    cur.execute("UPDATE Room_Member SET R_ID=%s, User_Member=%s, R_Class=%s, Status=%s, Room_BlackList=%s WHERE RM_ID=%s", (r_id, user_member, r_class, status, room_blacklist, id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Room member updated!'})


# Delete a room member
@app.route('/room_members/<int:id>', methods=['DELETE'])
def delete_room_member(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM Room_Member WHERE RM_ID=%s", (id,))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Room member deleted!'})

# CREATE
@app.route('/catelink', methods=['POST'])
def create_catelink():
    mysql = pymysql.connect(**db)
    if request.method == 'POST':
        r_id = request.json['r_id']
        ca_owner = request.json['ca_owner']
        ca_name = request.json['ca_name']

        cur = mysql.cursor()
        cur.execute("INSERT INTO CateLink (R_ID, CA_Owner, CA_Name) VALUES (%s, %s, %s)", (r_id, ca_owner, ca_name))
        mysql.commit()

        result = {
            'r_id': r_id,
            'ca_owner': ca_owner,
            'ca_name': ca_name
        }

        return jsonify({'result': result})

# READ
@app.route('/catelink', methods=['GET'])
def get_catelink():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM CateLink")
    rows = cur.fetchall()
    results = []
    for row in rows:
        result = {
            'ca_id': row[0],
            'r_id': row[1],
            'ca_owner': row[2],
            'ca_name': row[3]
        }
        results.append(result)
    return jsonify({'results': results})

# UPDATE
@app.route('/catelink/<int:ca_id>', methods=['PUT'])
def update_catelink(ca_id):
    mysql = pymysql.connect(**db)
    if request.method == 'PUT':
        ca_owner = request.json['ca_owner']
        ca_name = request.json['ca_name']

        cur = mysql.cursor()
        cur.execute("UPDATE CateLink SET CA_Owner=%s, CA_Name=%s WHERE CA_ID=%s", (ca_owner, ca_name, ca_id))
        mysql.commit()

        result = {
            'ca_id': ca_id,
            'ca_owner': ca_owner,
            'ca_name': ca_name
        }

        return jsonify({'result': result})

# DELETE
@app.route('/catelink/<int:ca_id>', methods=['DELETE'])
def delete_catelink(ca_id):
    mysql = pymysql.connect(**db)
    if request.method == 'DELETE':
        cur = mysql.cursor()
        cur.execute("DELETE FROM CateLink WHERE CA_ID=%s", (ca_id,))
        mysql.commit()
        return jsonify({'result': True})


# GET all PinTypes
@app.route('/pintypes', methods=['GET'])
def get_pintypes():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM PinType")
    result = cur.fetchall()
    cur.close()
    return jsonify(result)


# GET a PinType by ID
@app.route('/pintypes/<int:id>', methods=['GET'])
def get_pintype(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM PinType WHERE PT_ID = %s", (id,))
    result = cur.fetchone()
    cur.close()
    return jsonify(result)


# ADD a new PinType
@app.route('/pintypes', methods=['POST'])
def add_pintype():
    mysql = pymysql.connect(**db)
    pt_owner = request.json['pt_owner']
    editor = request.json['editor']
    r_id = request.json['r_id']
    pt_name = request.json['pt_name']
    pt_icons = request.json['pt_icons']
    pt_status = request.json['pt_status']

    cur = mysql.cursor()
    cur.execute("INSERT INTO PinType (PT_Owner, Editor, R_ID, PT_Name, PT_Icons, PT_Status) VALUES (%s, %s, %s, %s, %s, %s)",
                (pt_owner, editor, r_id, pt_name, pt_icons, pt_status))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'PinType added successfully!'})


# UPDATE an existing PinType
@app.route('/pintypes/<int:id>', methods=['PUT'])
def update_pintype(id):
    mysql = pymysql.connect(**db)
    pt_owner = request.json['pt_owner']
    editor = request.json['editor']
    r_id = request.json['r_id']
    pt_name = request.json['pt_name']
    pt_icons = request.json['pt_icons']
    pt_status = request.json['pt_status']

    cur = mysql.cursor()
    cur.execute("UPDATE PinType SET PT_Owner=%s, Editor=%s, R_ID=%s, PT_Name=%s, PT_Icons=%s, PT_Status=%s WHERE PT_ID=%s",
                (pt_owner, editor, r_id, pt_name, pt_icons, pt_status, id))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'PinType updated successfully!'})


# DELETE a PinType
@app.route('/pintypes/<int:id>', methods=['DELETE'])
def delete_pintype(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM PinType WHERE PT_ID = %s", (id,))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'PinType deleted successfully!'})

# GET all pins
@app.route('/pins', methods=['GET'])
def get_pins():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM PinMaps")
    pins = cur.fetchall()
    cur.close()
    return jsonify({'pins': pins})

# GET a single pin
@app.route('/pins/<int:pin_id>', methods=['GET'])
def get_pin(pin_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM PinMaps WHERE Pin_ID = %s", [pin_id])
    pin = cur.fetchone()
    cur.close()
    return jsonify({'pin': pin})

# POST a new pin
@app.route('/pins', methods=['POST'])
def add_pin():
    mysql = pymysql.connect(**db)
    pin_name = request.json['Pin_Name']
    pin_location = request.json['Pin_Location']
    pin_detail = request.json['Pin_Detail']
    pin_tell = request.json['Pin_Tell']
    pin_link = request.json['Pin_Link']
    pin_address = request.json['Pin_Address']
    pin_icons = request.json['Pin_Icons']
    pin_owner = request.json['Pin_Owner']
    pt_id = request.json['PT_ID']
    r_id = request.json['R_ID']
    
    cur = mysql.cursor()
    cur.execute("INSERT INTO PinMaps (Pin_Name, Pin_Location, Pin_Detail, Pin_Tell, Pin_Link, Pin_Address, Pin_Icons, Pin_Owner, PT_ID, R_ID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (pin_name, pin_location, pin_detail, pin_tell, pin_link, pin_address, pin_icons, pin_owner, pt_id, r_id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'New pin added.'})

# PUT update an existing pin
@app.route('/pins/<int:pin_id>', methods=['PUT'])
def update_pin(pin_id):
    mysql = pymysql.connect(**db)
    pin_name = request.json['Pin_Name']
    pin_location = request.json['Pin_Location']
    pin_detail = request.json['Pin_Detail']
    pin_tell = request.json['Pin_Tell']
    pin_link = request.json['Pin_Link']
    pin_address = request.json['Pin_Address']
    pin_icons = request.json['Pin_Icons']
    pin_owner = request.json['Pin_Owner']
    pt_id = request.json['PT_ID']
    r_id = request.json['R_ID']
    
    cur = mysql.cursor()
    cur.execute("UPDATE PinMaps SET Pin_Name = %s, Pin_Location = %s, Pin_Detail = %s, Pin_Tell = %s, Pin_Link = %s, Pin_Address = %s, Pin_Icons = %s, Pin_Owner = %s, PT_ID = %s, R_ID = %s WHERE Pin_ID = %s", (pin_name, pin_location, pin_detail, pin_tell, pin_link, pin_address, pin_icons, pin_owner, pt_id, r_id, pin_id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Pin updated.'})


# Create a new link
@app.route('/link', methods=['POST'])
def add_link():
    mysql = pymysql.connect(**db)
    data = request.get_json()
    cur = mysql.cursor()
    cur.execute("INSERT INTO Link (CA_ID, Owner, Link, L_Icons) VALUES (%s, %s, %s, %s)", 
                (data['CA_ID'], data['Owner'], data['Link'], data['L_Icons']))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Link created successfully.'})

# Get all links
@app.route('/link', methods=['GET'])
def get_links():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Link")
    rows = cur.fetchall()
    cur.close()
    links = []
    for row in rows:
        link = {
            'L_ID': row[0],
            'CA_ID': row[1],
            'Owner': row[2],
            'Link': row[3],
            'L_Icons': row[4]
        }
        links.append(link)
    return jsonify(links)

# Get a single link
@app.route('/link/<int:l_id>', methods=['GET'])
def get_link(l_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Link WHERE L_ID = %s", [l_id])
    row = cur.fetchone()
    cur.close()
    if row:
        link = {
            'L_ID': row[0],
            'CA_ID': row[1],
            'Owner': row[2],
            'Link': row[3],
            'L_Icons': row[4]
        }
        return jsonify(link)
    else:
        return jsonify({'message': 'Link not found.'}), 404

# Update a link
@app.route('/link/<int:l_id>', methods=['PUT'])
def update_link(l_id):
    mysql = pymysql.connect(**db)
    data = request.get_json()
    cur = mysql.cursor()
    cur.execute("UPDATE Link SET CA_ID = %s, Owner = %s, Link = %s, L_Icons = %s WHERE L_ID = %s", 
                (data['CA_ID'], data['Owner'], data['Link'], data['L_Icons'], l_id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Link updated successfully.'})

# Delete a link
@app.route('/link/<int:l_id>', methods=['DELETE'])
def delete_link(l_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM Link WHERE L_ID = %s", [l_id])
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Link deleted successfully.'})

# CREATE
@app.route('/chat', methods=['POST'])
def add_chat():
    mysql = pymysql.connect(**db)
    sender = request.json['sender']
    receiver = request.json['receiver']
    text = request.json['text']

    cur = mysql.cursor()
    cur.execute("INSERT INTO Chat (Sender, Receiver, Text) VALUES (%s, %s, %s)", (sender, receiver, text))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'Chat added successfully'})

# READ ALL
@app.route('/chat', methods=['GET'])
def get_chats():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Chat")
    chats = cur.fetchall()
    cur.close()

    return jsonify(chats)

# READ ONE
@app.route('/chat/<int:c_id>', methods=['GET'])
def get_chat(c_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("SELECT * FROM Chat WHERE C_ID = %s", (c_id,))
    chat = cur.fetchone()
    cur.close()

    return jsonify(chat)

# UPDATE
@app.route('/chat/<int:c_id>', methods=['PUT'])
def update_chat(c_id):
    mysql = pymysql.connect(**db)
    sender = request.json['sender']
    receiver = request.json['receiver']
    text = request.json['text']

    cur = mysql.cursor()
    cur.execute("UPDATE Chat SET Sender=%s, Receiver=%s, Text=%s WHERE C_ID=%s", (sender, receiver, text, c_id))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'Chat updated successfully'})

# DELETE
@app.route('/chat/<int:c_id>', methods=['DELETE'])
def delete_chat(c_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM Chat WHERE C_ID=%s", (c_id,))
    mysql.commit()
    cur.close()

    return jsonify({'message': 'Chat deleted successfully'})

# GET all social numbers
@app.route('/socialnumbers', methods=['GET'])
def get_social_numbers():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('SELECT * FROM SocialNumber')
    result = cur.fetchall()
    cur.close()
    return jsonify(result)

# GET social number by id
@app.route('/socialnumbers/<int:social_number_id>', methods=['GET'])
def get_social_number(social_number_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('SELECT * FROM SocialNumber WHERE SN_ID = %s', (social_number_id,))
    result = cur.fetchone()
    cur.close()
    return jsonify(result)

# POST a new social number
@app.route('/socialnumbers', methods=['POST'])
def add_social_number():
    mysql = pymysql.connect(**db)
    CA_ID = request.json['CA_ID']
    SN_name = request.json['SN_name']
    SN_Icons = request.json['SN_Icons']
    number = request.json['number']
    cur = mysql.cursor()
    cur.execute('INSERT INTO SocialNumber (CA_ID, SN_name, SN_Icons, number) VALUES (%s, %s, %s, %s)',
                (CA_ID, SN_name, SN_Icons, number))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Social number added successfully!'})

# PUT (update) a social number by id
@app.route('/socialnumbers/<int:social_number_id>', methods=['PUT'])
def update_social_number(social_number_id):
    mysql = pymysql.connect(**db)
    CA_ID = request.json['CA_ID']
    SN_name = request.json['SN_name']
    SN_Icons = request.json['SN_Icons']
    number = request.json['number']
    cur = mysql.cursor()
    cur.execute('UPDATE SocialNumber SET CA_ID=%s, SN_name=%s, SN_Icons=%s, number=%s WHERE SN_ID=%s',
                (CA_ID, SN_name, SN_Icons, number, social_number_id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Social number updated successfully!'})

# DELETE a social number by id
@app.route('/socialnumbers/<int:social_number_id>', methods=['DELETE'])
def delete_social_number(social_number_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('DELETE FROM SocialNumber WHERE SN_ID = %s', (social_number_id,))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Social number deleted successfully!'})

# get all users
@app.route('/users')
def get_users():
    mysql = pymysql.connect(**db)
    mysql.ping() 
    with mysql.cursor() as cursor:         
        cursor.execute("SELECT * FROM Users")
        rows = cursor.fetchall()
        return jsonify(rows)    



# get a user by id
@app.route('/users/<string:data>')
def get_user(data):
    mysql = pymysql.connect(**db)
    data_list = data.split(",")
    if(len(data_list)>1):
        sql =   f'SELECT * FROM Users WHERE U_Email = {data_list[0]}" and `U_Password` = "{data_list[1]}'
    else:
         sql =   f"SELECT * FROM Users WHERE U_Email = {data}"
    if(data[0]!='"'):
        sql =   f"SELECT * FROM Users WHERE U_ID = {data}"
    with mysql.cursor() as cursor:         
        cursor.execute(sql)
        rows = cursor.fetchall()
        return jsonify(rows)    

# create a new user
@app.route('/users', methods=['POST'])
def add_user():
    mysql = pymysql.connect(**db)
    data = request.get_json()
    u_name = data['U_Name']
    u_email = data['U_Email']
    u_image = data['U_Image']
    u_username = data['U_Username']
    u_password = data['U_Password']
    u_location = data['U_Location']
    u_user_tell = data['U_User_Tell']
    u_class = 1
    u_status = 1
    u_show_tell = 1
    
    
    cur = mysql.cursor()
    sql = f"INSERT INTO `Users`( `U_Name`, `U_Email`, `U_Image`, `U_Username`, `U_Password`, `U_Location`, `U_Status`, `U_User_Tell`, `U_Show_Tell`, `U_Class`) VALUES ('{u_name}', '{u_email}', '{u_image}', '{u_username}', '{u_password}', '{u_location}', '{u_status}', '{u_user_tell}', '{u_show_tell}', '{u_class}')"
    cur.execute(sql)
    mysql.commit()
    return ""

# update an existing user position
@app.route('/users/location/<int:user_id>', methods=['PUT'])
def update_user_location(user_id):
    mysql = pymysql.connect(**db)
    data = request.get_json()
    u_location = data['U_Location']
    u_status = data['U_Status']

    cur = mysql.cursor()
    cur.execute("UPDATE Users SET U_Location = %s, U_Status = %s  WHERE U_ID = %s",
                ( u_location, u_status, user_id))
    mysql.commit()
    

    result = {
        'U_ID': user_id,
        'U_Location': u_location,
        'U_Status': u_status,
    }

    return jsonify(result)

# update an existing user
@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    mysql = pymysql.connect(**db)
    data = request.get_json()
    u_name = data['U_Name']
    u_email = data['U_Email']
    u_image = data['U_Image']
    u_username = data['U_Username']
    u_password = data['U_Password']
    u_location = data['U_Location']
    u_status = data['U_Status']
    u_user_tell = data['U_User_Tell']
    u_show_tell = data['U_Show_Tell']
    u_class = data['U_Class']

    cur = mysql.cursor()
    cur.execute("UPDATE Users SET U_Name = %s, U_Email = %s, U_Image = %s, U_Username = %s, U_Password = %s, U_Location = %s, U_Status = %s, U_User_Tell = %s, U_Show_Tell = %s, U_Class = %s WHERE U_ID = %s",
                (u_name, u_email, u_image, u_username, u_password, u_location, u_status, u_user_tell, u_show_tell, u_class, user_id))
    mysql.commit()
    

    result = {
        'U_ID': user_id,
        'U_Name': u_name,
        'U_Email': u_email,
        'U_Image': u_image,
        'U_Username': u_username,
        'U_Password': u_password,
        'U_Location': u_location,
        'U_Status': u_status,
        'U_User_Tell': u_user_tell,
        'U_Show_Tell': u_show_tell,
        'U_Class': u_class
    }

    return jsonify(result)

# delete a user
@app.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute("DELETE FROM Users WHERE U_ID = %s", [user_id])
    mysql.commit()

    result = {
        'message': 'User has been deleted',
        'U_ID': user_id
    }

    return jsonify(result)


# Get all admin targets
@app.route('/admin_target', methods=['GET'])
def get_admin_targets():
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('SELECT * FROM Admin_Target')
    admin_targets = cur.fetchall()
    cur.close()
    print(jsonify(admin_targets))
    return (admin_targets)

# Get a single admin target by ID
@app.route('/admin_target/<int:id>', methods=['GET'])
def get_admin_target(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('SELECT * FROM Admin_Target WHERE AT_ID = %s', (id,))
    admin_target = cur.fetchone()
    cur.close()
    return jsonify(admin_target)

# Create a new admin target
@app.route('/admin_target', methods=['POST'])
def create_admin_target():
    mysql = pymysql.connect(**db)
    data = request.get_json()
    target_u_id = data['Target_U_ID']
    u_class = data['U_Class']
    start_time = data['StartTime']
    end_time = data['EndTime']
    block = data['Block']
    alert = data['Alert']
    cur = mysql.cursor()
    cur.execute('INSERT INTO Admin_Target ( Target_U_ID, U_Class, StartTime, EndTime, Block, Alert) VALUES ( %s, %s, %s, %s, %s, %s, %s)', ( target_u_id, u_class, start_time, end_time, block, alert))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Admin target created'})

# Update an existing admin target
@app.route('/admin_target/<int:id>', methods=['PUT'])
def update_admin_target(id):
    mysql = pymysql.connect(**db)
    data = request.get_json()
    u_id = data['U_ID']
    target_u_id = data['Target_U_ID']
    u_class = data['U_Class']
    start_time = data['StartTime']
    end_time = data['EndTime']
    block = data['Block']
    alert = data['Alert']
    time = data['Time']
    cur = mysql.cursor()
    cur.execute('UPDATE Admin_Target SET U_ID = %s, Target_U_ID = %s, U_Class = %s, StartTime = %s, EndTime = %s, Block = %s, Alert = %s, Time = %s WHERE AT_ID = %s', (u_id, target_u_id, u_class, start_time, end_time, block, alert, time, id))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Admin target updated'})

# Delete an admin target
@app.route('/admin_target/<int:id>', methods=['DELETE'])
def delete_admin_target(id):
    mysql = pymysql.connect(**db)
    cur = mysql.cursor()
    cur.execute('DELETE FROM Admin_Target WHERE AT_ID = %s', (id,))
    mysql.commit()
    cur.close()
    return jsonify({'message': 'Admin target deleted'})


if __name__ == '__main__':
    app.run(debug=True,port=5050)
