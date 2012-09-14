package/*flkf*/ org.scala-mode2
object Arrays/*fltf*/{
  def/*flkf*/ splice/*flfnf*/[T/*fltf*/:ClassManifest/*fltf*/](
      a:Array/*fltf*/[T/*fltf*/],
      start:Int/*fltf*/,
      end:Int/*fltf*/,
      b:Array/*fltf*/[T/*fltf*/]):Array/*fltf*/[T/*fltf*/] = {
    val/*flkf*/ c/*flvnf*/ = new/*flkf*/ Array/*fltf*/[T/*fltf*/](
		a.size + (b.size - (end - start)))
    System/*fltf*/.arraycopy(a, 0, c, 0, start)
    System/*fltf*/.arraycopy(b, 0, c, start, b.size)
    System/*fltf*/.arraycopy(a, end + 1, c, start + b.size, a.size - end - 1)
    c
  }
}
