// Task:
// #1. Refactor this code to avoid SOLID principles violation
public class Program
{
	public void Main(string [] args)
	{
		FileReader fileReader = new FileReader(args[0]);
		FileSplitter fileSplitter = new FileSplitter();
		IEnumerable<string> lines = fileReader.Read();
		IEnumerable<PersonDTO> persons = fileSplitter.TextSplitter(lines);;
		DataBaseProcessor dataProcessor = new DataBaseProcessor();
		database.InsertIntoPerson(persons);
	}
}

public class DataBaseProcessor
{
	public void InsertIntoPerson(PersonDTO  person)
	{
		var connection = new SqlConnection("server=(local);database=CaspioDb");
		connection.Open();

		var command = connection.CreateCommand();
		command.CommandText = "INSERT INTO PersonTable (FirstName, LastName, Email) VALUES (@FirstName, @LastName, @Email)";
		command.Parameters.AddWithValue("@FirstName", person.FirstName);
		command.Parameters.AddWithValue("@LastName", person.LastName);
		command.Parameters.AddWithValue("@Email", person.Email);
		command.ExecuteNonQuery();

		connection.Close();
	}

	public void InsertIntoPerson(IEnumerable<PersonDTO> person)
	{
		foreach (var item in person)
		{
			InsertIntoPerson(item);
		}
	}
}

public interface IReader
{
	IEnumerable<string> Read();
}

public interface ISplitter
{
	PersonDTO LineSplitter(string line);
}

public class FileReader : IReader
{
	private readonly string _filename;

	public FileReader(string filename)
	{
		_filename = filename
	}
	public IEnumerable<string> Read()
	{
		using (TextReader textReader = new StreamReader(_filename))
		{
			while (textReader.Peek() != -1)
			{
				yield return textReader.ReadLine();
			}

		}
	}
}

public class FileSplitter : ISplitter
{
	public PersonDTO LineSplitter(string line)
	{
		if (line == string.Empty)
		{
			return null;
		}

		string[] columns = line.Split(new string[] { ";" }, StringSplitOptions.None);
		PersonDTO personDTO = new PersonDTO();
		personDTO.FirstName = columns[0];
		personDTO.LastName = columns[1];
		personDTO.Email = columns[2];

		return personDTO;
	}

	public IList<PersonDTO> TextSplitter(IEnumerable<string> lines)
	{
		IList<PersonDTO>persons = new List<PersonDTO>();
		foreach (var line in lines)
		{
			persons.Add(LineSplitter(line));
		}

		return persons;
	}
}

public class PersonDTO
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
	public string Email { get; set; }
	public override string ToString()
	{
		return $"{FirstName} + {LastName} + {Email}";
	}
}

