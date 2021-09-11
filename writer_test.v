module httpchunkwriter

import takkyuuplayer.bytebuf

fn test_new() {
	w := bytebuf.Buffer{}
	{
		// no size
		writer := new(writer: w)

		assert writer.size == 20
		if writer.writer is bytebuf.Buffer {
			assert writer.writer == w
		} else {
			assert false
		}
	}
	{
		// with size
		writer := new(writer: w, size: 1024)

		assert writer.size == 1024
	}
	{
		// idempotent
		writer := new(writer: w)
		w1 := new(writer: writer)

		assert w1.size == writer.size
		if writer.writer is bytebuf.Buffer && w1.writer is bytebuf.Buffer {
			assert w1.writer == writer.writer
		} else {
			assert false
		}
	}
}

fn test_writer() ? {
	{
		// big enough chunk
		mut w := bytebuf.Buffer{}
		mut writer := new(writer: w)
		written := writer.write('abc'.bytes()) ?

		assert w.bytes() == '3\r\nabc\r\n'.bytes()
		assert written == 3
	}
	{
		// small chunk
		mut w := bytebuf.Buffer{}
		mut writer := new(writer: w, size: 1)
		written := writer.write('abc'.bytes()) ?

		assert w.bytes() == '1\r\na\r\n1\r\nb\r\n1\r\nc\r\n'.bytes()
		assert written == 3
	}
	{
		//  close
		mut w := bytebuf.Buffer{}
		mut writer := new(writer: w)
		writer.close() ?

		assert w.bytes() == '0\r\n\r\n'.bytes()
	}
}
