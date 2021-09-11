module chunkio

import io
import strconv

// Writer implements http1.1's chunking for an io.Writer object.
pub struct Writer {
	size int
mut:
	writer io.Writer
}

// Config are options that can be given to a writer
pub struct WriterConfig {
	size   int = 20 // the number of bytes in a chunk.
	writer io.Writer
}

pub fn new_writer(o WriterConfig) &Writer {
	if o.writer is Writer {
		return o.writer
	}
	if o.size < 1 {
		panic('new should be called with a positive `size`')
	}

	return &Writer{
		size: o.size
		writer: o.writer
	}
}

// write writes the contents of p into the chunk.
// It returns the number of bytes written.
pub fn (mut c Writer) write(buf []byte) ?int {
	mut sum := 0
	for start := 0; start < buf.len; start += c.size {
		end := if start + c.size < buf.len { start + c.size } else { buf.len }

		p := buf[start..end]
		c.writer.write(strconv.v_sprintf('%x\r\n', p.len).bytes()) ?
		c.writer.write(p) ?
		c.writer.write('\r\n'.bytes()) ?

		sum += p.len
	}
	return sum
}

pub fn (mut c Writer) close() ? {
	c.writer.write('0\r\n\r\n'.bytes()) ?
}
