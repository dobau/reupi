import glob

log_full_name = 'append.log'
log_pattern = '*.log*'

with open(log_full_name, 'w') as log_full:

	for f in glob.glob(log_pattern):

		print('Appending ' + f)
		
		with open(f) as log:
			log_full.write(log.read())			
