// Task:
// #1. Why results are not the same after we call Console.WriteLine("Area={0}", shape.Area);? How to fix it?
// #2. Refactor this code to avoid SOLID principles violation.

class CaspioMath
{
	static void Main(string[] args)
	{
		Shape shape = new Rectangle(10,5);
		shape.Area();
		shape = new Square(4);
		shape.Area();

		Console.ReadLine();
	}
}

public abstract class Shape
{
	public abstract int Area();
}

public class Rectangle : Shape
{
	private int _width;
	private int _height;

	public int Width
	{
		get { return _width; }
		set { _width = value; }
	}

	public int Height
	{
		get { return _height; }
		set { _height = value; }
	}

	public Rectangle(int width, int height)
	{
		_width = width;
		_height = height;		
	}

	public override int Area()
	{
		return _height * _width;
	}
}

public class Square : Shape
{
	private int _edge;

	public int Edge
	{
		get { return _edge; }
		set { _edge = value; }
	}
	public Square(int edge)
	{
		_edge = edge;
	}

	public override int Area()
	{
		return _edge * _edge;
	}
}
