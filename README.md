<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/2762/2762275.png" width="100" alt="Test Tube Icon" />
</p>
<p align="center">
  <h1 align="center">hy1am: Minimalist Testing Framework for Hy</h1>
</p>
<p align="center">
    <em>A straightforward and expressive testing library for Hy programming, inspired by Common Lisp's 1am.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/prasxanth/hy1am?style=flat&logo=git&logoColor=white&color=2D5900" alt="license">
	<img src="https://img.shields.io/github/last-commit/prasxanth/hy1am?style=flat&logo=git&logoColor=white&color=808080" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/prasxanth/hy1am?style=flat&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/prasxanth/hy1am?style=flat&color=0080ff" alt="repo-language-count">
</p>
<p align="center">
		<em>Empowered by the tools below.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/Hy-7790B2.svg?style=flat&logo=python&logoColor=white" alt="Hy Language">
	<img src="https://img.shields.io/badge/Rich-FF6E6E.svg?style=flat&logo=github&logoColor=white" alt="Rich Formatting">
</p>
<hr>

## Features 🌟
- **Simple Syntax**: Effortlessly create tests using Hy's powerful macro system.
- **Rich Output**: Enjoy beautifully formatted output that makes test results easy to read and interpret.
- **Modular Design**: Organize your tests into suites for improved structure and clarity.

## Installation 🔧
Clone the `hy1am` repository to your local machine to begin:
```bash
git clone https://github.com/your-repo/hy1am.git
```
Before you can use this script, make sure you have the required libraries installed. You can install them using pip:

```bash
pip install -r requirements.txt
```
 
Install the package using `setup.py`. The `--user` flag is optional:
```bash
python3 setup.py install --user
```
Alternatively, for development mode:
```bash
python3 setup.py develop --user
```

## Usage 📖
### Writing Tests 📝
Define individual tests using the `is?` macros and group them with the `deftest` macro:
```hy
(deftest addition-test
  (is? = (+ 1 1) 2 "Checks if 1 + 1 equals 2")
  (is? = (+ 0 3) 3 "Checks if 0 + 3 equals 3"))
```
The last description argument in `is?` is mandatory.

The `deftest` macro generates a function. The function's name is the one provided to the macro, prefixed with `test-`. For example, the above code creates a function called `test-addition`.

Here's another example:
```hy
(deftest multiplication-test
  (is? = (* 1 1) 1 "Checks if 1 * 1 equals 1"))
```

Use the `signal?` macro to test for exceptions:
```hy
(deftest division-test
  (signal? (/ 5 0) ZeroDivisionError "division by zero" "div by zero"))
```

Tests can be grouped into suites with the `defsuite` macro:
```hy
(defsuite math-tests
  "Basic Math Tests" [(test-addition-test)
                      (test-multiplication-test)
                      (test-division-test)])
```
The `defsuite` macro also generates a function, with the name provided to the macro prefixed with `test-suite-`. Thus, the above would create a function called `test-suite-math-tests`.

### Running Tests ▶️
Although tests and test suites can be run independently, using the `run-test-suites` function simplifies the process. It requires the package name as its first argument, followed by one or more suite arguments:
```hy
(run-test-suites "my-hy-app" (test-suite-math-tests))
```
A practical approach is to group tests into a single suite at the sub-module level and use `run-test-suites` to run all the tests from all sub-modules in the main test file:
```hy
(run-test-suites "package-name" (test-suite-sub-module-1) (test-suite-sub-module-2) ...)
```

### Test Output 📊
Test results are displayed using styled

 formatting from the `rich` library through the `report-test-results` function. This function processes the output from `run-test-suites` to display a comprehensive report of all tests, including metadata and a summary:
```hy
(let [test-results (run-test-suites "example-package" (test-suite-example-suite))
      timestamp (->> test-results (:start_datetime) (re.sub r"\..*|-|:| " ""))
      log-folder (Path "logs")
      csv-path (/ log-folder (Path f"{timestamp}.csv"))
      html-path (/ log-folder (Path f"{timestamp}.html"))]
  (report-test-results test-results :csv-path csv-path :html-path html-path))
```
The `report-test-results` function can also save results to CSV or HTML files, with the HTML file maintaining the formatting seen in the command line.

## Contributing 🤝
Contributions are welcome. Please fork the repository, make your changes, and submit a pull request.

## License 📄
This project is open source and distributed under the BSD 3-Clause License. Refer to the LICENSE file for more details.
