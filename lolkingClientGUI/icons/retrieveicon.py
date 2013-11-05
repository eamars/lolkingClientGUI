USER_ICON_TEMPLATE = "http://lkimg.zamimg.com/shared/riot/images/profile_icons/profileIcon{}.jpg"
IMAGE_FILE_NAME = "profileIcon{}.jpg"

from urllib.request import urlopen

for i in range(500, 600):
    
    try:
        print(i)
        buffer = urlopen(USER_ICON_TEMPLATE.format(i))
        fp = open(IMAGE_FILE_NAME.format(i), 'wb')
        fp.write(buffer.read())
        fp.close()
    except Exception as e:
        print(e)
    
