import re, sys
sql = sys.stdin.read()
regex = re.compile(r'/\*![^\n]* \*/;\n', re.M)
print regex.sub('', sql)