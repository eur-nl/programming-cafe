# Learn how to manage your data using research software

In this fifth session of the Programming Café, we will have a look at the content of the Research Data Management Week and find out, whether and how we can automate or ease these processes using research software and/or tools.

### What will we cover?
**Data sharing**
- De-identification of data

**Collaborating**
- Automatic creation of project structures
- Generating README files
- Check your file naming automatically
- Check whether your file format is preferred
- Have a look at CodeMeta

**Other useful tools and software**
- Quarto
- Software Management Plan

Hopefully, you also see some known faces in the room: Some of the Data Stewards joined us today to answer your questions!

## Data sharing – De-identification of data
In last Tuesday's session, you learned how to share your data responsibly. You explored the de-identification of qualitative data and learned how to prepare your publication package.

Programming can assist you in de-identifying your data! Using research software, you can choose to either pseudonymize or anonymize it. Let’s take a closer look at how we can replace personal names, distort ages, and redact ZIP codes in **[this data](extras/lesson_5.zip)**:


```python
# Read in file
from pathlib import Path
import pandas
import csv

data_path = Path('..') / "static" / "extras"
df = pandas.read_csv(data_path / "Example_Data.csv")

# Replace the names with pseudonyms and save the new mapping
df['Username'] = ['User_' + str(i) for i in range(1, len(df) + 1)]
map = df[['Name', 'Surname', 'Username']]
map.to_csv(data_path / "mapping.csv", index = False)

# Redact the ZIP Code
df['ZIP Code'] = df['ZIP Code'].apply(lambda x: str(x)[0] + 'xxxx')

# Shorten the Birth date to year and distort year
df['Birth_Date_distorted'] = df['Birth Date'].apply(lambda x: int(str(x)[-4:])+5)

# We can also round the number instead
df['Birth_Date_rounded'] = df['Birth Date'].apply(lambda x: round(int(str(x)[-4:]), -1) )

# Print in new file
df = df.drop(columns = ['Name', 'Surname'])
df = df[['Username', 'Birth_Date_rounded', 'Gender', 'ZIP Code', 'Complaint']]
df.to_csv(data_path / "NewData.csv", index = False)

print(df)
```

      Username  Birth_Date_rounded  Gender ZIP Code        Complaint
    0   User_1                1960    Male    2xxxx  Short of breath
    1   User_2                1960    Male    2xxxx       Chest pain
    2   User_3                1960  Female    2xxxx      Painful eye
    3   User_4                1960  Female    2xxxx         Wheezing
    4   User_5                1960  Female    2xxxx    Aching joints
    5   User_6                1960  Female    2xxxx       Chest pain
    6   User_7                1960    Male    2xxxx  Short of breath


If you have saved a specific mapping, you can use it to pseudonymize textual data. In the following example, we used the generated usernames to replace the names in the text.


```python
# Use your mapping file to change texts
# Read in the mapping
mapping = {}
with open (data_path / "mapping_manual.csv", mode = 'r', encoding = 'utf-8') as mapfile:
    map = csv.reader(mapfile, delimiter=',')
    for line in map:
        mapping[line[0]] = line[1]

with open(data_path / 'text_example.txt', mode = 'r', encoding = 'utf-8') as txtfile:
    content = txtfile.read()

# Replace words in file with mapping file content
new_content, document = content, content
for key, value in mapping.items():
    new_content = new_content.replace(key, value)
    document = document.replace(key, f"{value} [Replaced - {key}]")

# Save two versions to also allow for documentation in the text
with open(data_path / 'output.txt', mode = 'w', encoding = 'utf-8') as outfile:
    print(new_content, file = outfile)

with open(data_path / 'documentation.txt', mode = 'w', encoding = 'utf-8') as docfile:
    print(document, file = docfile)

```

To truly anonymize the data instead, I recommend using an open-source tool such as [Textwash](https://github.com/ben-aaron188/textwash). Let’s take a quick look at how to use it:

First, download the module from GitHub. Then, open the terminal, navigate to the directory containing the downloaded files, and enter the following commands
```console
conda create -n textwash python=3.9
conda activate textwash
pip install -r requirements.txt
```
Do not forget to [download the models](https://drive.google.com/file/d/1YBccngYE3lvod87TI6UIhBzrN7nY9vHS/view?usp=sharing) and paste them into the data folder!

After preparing the folder, you can run the code below!
```console
python3 anon.py --language en --input_dir my_documents --output_dir anonymised_documents --cpu
```

With this, this text here:
```text
In this interview, we talk with Sean Curtis about his wife Marion Aaker. Sean Curtis said that his wife has been wheezing since some weeks, while he mainly feels short of breath. Both born in 1965, Doctors may think it is related to their age and that were born in Manchester.
```

Changes to this:
```text
In this interview, we talk with PERSON_FIRSTNAME_1 PERSON_LASTNAME_1 about PRONOUN wife PERSON_FIRSTNAME_2 PERSON_LASTNAME_2. PERSON_FIRSTNAME_1 PERSON_LASTNAME_1 said that PRONOUN wife has been wheezing since some weeks, while PRONOUN mainly feels short of breath. Both born in DATE_1, Doctors DATE_1 think it is related to their age and that were born in LOCATION_1.
```

## Collaborating - Create folder structure

In last Thursday's session on collaboration, you learned more about structuring a research project. Did you know that Python can help you create a structured project folder?

The following code creates a folder structure as recommended by the [good-enough-project](https://github.com/bvreede/good-enough-project):


```python
from pathlib import Path

def create_folder_setup(project_name):
    # Create a project folder in documents
    project_path = Path.home() / 'Documents' / project_name
    if not Path(project_path).exists():
        Path.mkdir(project_path)

    # Create a list of folders that should be created
    folders = ['src', 'data', 'docs', 'results', 'config', 'bin', 'data/raw', 'data/processed', 'data/temp', 'docs/manuscript', 'docs/reports', 'results/figures', 'results/output']
    # Create folders
    for folder in folders:
        if not Path(project_path / folder).exists():
            Path.mkdir(project_path / folder)

    # Create a list of files that should be created
    files = ['README.md', 'LICENSE.md', 'CITATION.md', '.gitignore', 'requirements.txt', 'docs/manuscript/notes.txt']
    # Create files
    for file in files:
        if not Path(project_path / file).exists():
            Path.touch(project_path / file)

create_folder_setup("TestProject")

```

Although we’ve already created an empty README file, there are useful templates available to help you complete it. In [this tutorial](https://realpython.com/readme-python-project/), you’ll find specific editors designed to assist with filling them in.

## Collaborating - How to paste the folder and file structure into the README

What we might want to use Python for directly is inserting file paths into a README. For that, we can reuse content from another Programming Café session.

The goal is to create the following overview:
TestProject/
├──.Rhistory
├──LICENSE.md
├──requirements.txt
├──README.md
├──.gitignore
├──CITATION.md
├──validated_files.csv
	├──bin/
	├──config/
	├──docs/
		├──manuscript/
		├──notes.txt
		├──reports/
	├──results/
		├──output/
		├──figures/
	├──data/
		├──temp/
		├──processed/
		├──raw/
	├──src/



```python
from pathlib import Path

def generate_README(project_path):
  # Open the Readme file, print the header and then all information about the files
  with open(project_path /"README.md", mode = "w", encoding = "utf-8") as file_out:
      # for every directory/folder that we find...
      for dirpath, dirnames, files in Path.walk(project_path):

          # calculate needed indent by looking at the depth of the directory
          dir_length = len(dirpath.parts) - len(project_path.parts)
          indent = dir_length * '\t'
          # print indented directory name
          print(f"{indent}├──{dirpath.name}/", file = file_out) if dir_length > 0 else print(f"{dirpath.name}/", file = file_out)

          #...iterate through files and print file information in the readme
          for file in files:
              print(f"{indent}├──{file}", file = file_out)

generate_README(Path.home() / 'Documents' / 'TestProject')
```

## Collaborating - How to check whether your file names fit your conventions

You can also use Python to verify whether your file names match the pattern you’ve chosen. You can create the pattern using one of these useful websites:
- https://regexr.com
- https://regex101.com

The example below matches it to the following file names `YYYYMMDD_ExperimentID_Task_Version`:

It fits the following file names:
- 19951231_exp1543_interview_v1.csv
- 20030128_exp1549_survey_v2.csv

If you want to know how to rename your files, have a look at the content of our [previous programming café](https://eur-nl.github.io/rs_training/lesson_2.html)!


```python
from pathlib import Path
import re

def validate_filenames(project_path):
    # Create file that will contain the files that have been validated
    with open(project_path /'validated_files.csv', 'w', newline='') as csvfile:
        validated = csv.writer(csvfile, delimiter='\t')
        # for every file in the project...
        for dirpath, dirnames, files in Path.walk(project_path):
            for file in files:
                # if it is a csv file...
                if file.endswith((".csv", ".txt", ".odt")):
                    # ...define pattern... (the example matches YYYYMMDD_expID_Task_Version)
                    # example file names: 19951231_exp1543_interview_v1.csv and 20030128_exp1549_survey_v2.csv
                    pattern = r"^(?:19|20)\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])_exp\d{4}_\w+_v\d+" # FILL IN YOUR FILE PATTERN HERE

                    # ...and test against pattern and print results
                    if re.match(pattern, file) is None:
                        validated.writerow([file,'tested','not consistent'])
                    else:
                        validated.writerow([file,'tested','consistent'])
                # else print that the file has not been tested
                else:
                    validated.writerow([file,'not tested','NA'])

validate_filenames(Path.home() / 'Documents' / 'TestProject')

```

## Collaborating - How to validate your file format
Using the same techniques as before, you can also use Python to check whether the file formats you’ve chosen are preferred. To do this, you’ll need to create a list of all preferred formats (you can base it on the DANS list of preferred file formats [here](https://dans.knaw.nl/en/file-formats/)).



```python
def validate_filetype(project_path):
        # for every file in the project...
        for dirpath, dirnames, files in Path.walk(project_path):
            for file in files:
                valid = ['.odt', '.pdf', '.txt', '.xml', '.html', '.md', '.ods', '.csv','.dat', '.sps', '.DO', '.R','.siard', '.sql', '.txt', '.py']
                # ...check whether file extension is NOT in list of preferred formats...
                if not any(file.endswith(ext) for ext in valid):
                    #... and print warning
                    print(f"{file} is not in a preferred file format")

validate_filetype(Path.home() / 'Documents' / 'TestProject')
```

    .Rhistory is not in a preferred file format
    .DS_Store is not in a preferred file format
    .gitignore is not in a preferred file format
    .DS_Store is not in a preferred file format
    .DS_Store is not in a preferred file format


### Other useful tools and links
- Quarto
- [OpenRefine](https://openrefine.org)
- [Software Management Plan](https://smp.research.software/interview?i=docassemble.SMPDecisionTree:data/questions/software.yml#page1): This decision tree tool helps you to fill in your own software management plan. While it is not mandatory for EUR researchers, I can only recommend filling it.
- Use [GitHub](https://github.com) to collaborate with others on your code
- [CodeMeta](https://codemeta.github.io)
- [How to FAIRify your Research Software](https://www.rug.nl/digital-competence-centre/research-data/content-fragments-data-management/guide-on-fair-software-ug-dcc-pdf-v1-0-2.pdf)
- [Assess your own software in terms of FAIR](https://fairsoftwarechecklist.net/v0.2/)
- [Recommendations for FAIR software](https://fair-software.nl/)
