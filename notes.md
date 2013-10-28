# Create new virtualenv
> vf new -p ~/.pythonz/pythons/CPython-2.7.5/bin/python agile

# On Ubuntu, install this before trying python-snappy
> sudo apt-get install libsnappy-dev libsnappy1
> pip install python-snappy
> pip install avro

# Trying to get scipy working
> sudo apt-get install libblas3 libblas-dev
> sudo apt-get install libatlas-dev
> sudo apt-get install libatlas-base-dev gfortran

# Got this stack trace when running gmail.py 1st time
# Probably need to catch the exception and skip over the 
# message if we can't decode
Traceback (most recent call last):
  File "./gmail.py", line 104, in <module>
    main()
  File "./gmail.py", line 98, in main
    slurper.slurp()
  File "/home/dc/workplace/Agile_Data_Code/ch03/gmail/gmail_slurper.py", line 137, in slurp
    self.write(email_hash)
  File "/home/dc/workplace/Agile_Data_Code/ch03/gmail/gmail_slurper.py", line 125, in write
    self.avro_writer.append(record)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/datafile.py", line 191, in append
    self.datum_writer.write(datum, self.buffer_encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 771, in write
    self.write_data(self.writers_schema, datum, encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 802, in write_data
    self.write_record(writers_schema, datum, encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 890, in write_record
    self.write_data(field.type, datum.get(field.name), encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 802, in write_data
    self.write_record(writers_schema, datum, encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 890, in write_record
    self.write_data(field.type, datum.get(field.name), encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 800, in write_data
    self.write_union(writers_schema, datum, encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 880, in write_union
    self.write_data(writers_schema.schemas[index_of_schema], datum, encoder)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 780, in write_data
    encoder.write_utf8(datum)
  File "/home/dc/.virtualenvs/agile/lib/python2.7/site-packages/avro/io.py", line 356, in write_utf8
    datum = datum.encode("utf-8")
UnicodeDecodeError: 'ascii' codec can't decode byte 0x91 in position 5: ordinal not in range(128)

