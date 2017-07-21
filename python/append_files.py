import glob
import os
import sys

def get_filepaths(directory, pattern):
    """
    This function will generate the file names in a directory 
    tree by walking the tree either top-down or bottom-up. For each 
    directory in the tree rooted at directory top (including top itself), 
    it yields a 3-tuple (dirpath, dirnames, filenames).
    """
    file_paths = []  # List which will store all of the full filepaths.

    # Walk the tree.
    for root, directories, files in os.walk(directory):
        for filename in files:
            if filename.endswith(pattern):
                # Join the two strings in order to form the full filepath.
                filepath = os.path.join(root, filename)
                file_paths.append(filepath)  # Add it to the list.

    return file_paths  # Self-explanatory.

def main(directory, output, pattern):
    with open(output, 'w') as log_full:
    
        for f in get_filepaths(directory, pattern):
            
            if (f != os.path.join(directory, output)):        
                print('Appending ' + f)

                with open(f) as log:
                    log_full.write(log.read())
                    
                log_full.write('\n')

def help():
    text = """
    
        Parâmetros: <diretorio> <output> <pattern>
    
    """
    
    print(text)
    
    
if (len(sys.argv) > 1 and sys.argv[1] == '-h'):
    help()
else:

    directory = sys.argv[1] if (len(sys.argv) > 1) else '.'
    output = sys.argv[2] if (len(sys.argv) > 2) else 'append_log.log'
    pattern = sys.argv[3] if (len(sys.argv) > 3) else ''

    main(directory, output, pattern)

