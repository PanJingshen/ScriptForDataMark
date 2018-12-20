'''
Created on Nov 9, 2015

@author: tmahrt
'''

def trimTextgrid(fn, outputFN):
    '''
    
    Values with zeroes in the decimal become ints.
    Floats get trimmed to 3 significant digits
    '''
    
    with open(fn, "r") as fd:
        data = fd.read()
    dataList = data.split("\n")
    newDataList = []
    for row in dataList:
        row = row.rstrip()
        try:
            head, tail = row.split("=")
            head = head.rstrip()
            tail = tail.strip()
            try:
                row = str(int(tail))
            except ValueError:
                tail = "%0.3f" % float(tail)
                if float(tail) == 0:
                    tail = "0"
            row = "%s = %s" % (head, tail)
        except ValueError:
            pass
        finally:
            newDataList.append(row.rstrip())

    outputTxt = "\n".join(newDataList)
    with open(outputFN, "w") as fd:
        fd.write(outputTxt)


def trimTextgrid_short(fn, outputFN):
    
    with open(fn, "r") as fd:
        data = fd.read()
    dataList = data.split("\n")
    newDataList = []
    for row in dataList:
        try:
            try:
                row = str(int(row))
            except ValueError:
                row = "%0.3f" % float(row)
                if float(row) == 0:
                    row = "0"
        except ValueError:
            pass
        finally:
            newDataList.append(row)

    outputTxt = "\n".join(newDataList)
    with open(outputFN, "w") as fd:
        fd.write(outputTxt)
