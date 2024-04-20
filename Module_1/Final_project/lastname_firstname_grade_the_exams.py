import os
import re
def  open_file():
    while True:
        filename=input("Enter a filename:")
        try:
            dir=os.path.join("D:\DS_MMC\Module_1\Final_project\Data Files",f"{filename}.txt")
            with open(dir,"r") as f:
                data=f.read()  
            print(f"Successfully opened {filename}")
            break 
        except :
            print("Sorry, I can't find this filename")
  
    return data
data=open_file()

def data_analys(data):
    lst = data.split("\n")
    student=[]
    error_26 = []
    error_N = []
    print("**** ANALYZING ****")
    for i in range(len(lst)):
        student.append(lst[i].split(","))
        if len(student[i]) != 26:
            print("Invalid line of data: does not contain exactly 26 values:")
            print(lst[i])
            error_26.append(list[i])
        elif bool(re.search(r"\b[N][0-9]{8}\b", student[i][0])) != True:
            print("Invalid line of data: N# is invalid:")
            print(lst[i])
            error_N.append(list[i])
    if len(error_26)+len(error_N) == 0: print("No errors found!")
    print("**** REPORT ****")
    print(f"Total valid lines of data: {len(lst)-len(error_26)-len(error_N)}")
    print(f"Total invalid lines of data: {len(error_26)+len(error_N)}")
    return lst,student,error_26,error_N
lst,student,error_26,error_N=data_analys(data)
print(lst)