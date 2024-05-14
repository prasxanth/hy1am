(require
  hyrule [->])

(import
  inspect
  toolz [concatv]
  datetime [datetime])

(defmacro is? [op actual expected description]
  `(try
     (assert (~op ~actual ~expected))
     f"✔ Pass: {~description}"
     (except [e AssertionError]
       f"✘ Fail: {~description} => Actual: {~actual} !{'~op} Expected: {~expected}")))

(defmacro signal? [actual sig msg description]
  `(try ~actual (except [err ~sig] (is? = (str err) ~msg ~description))))

(defn get-func-info [func]
  (when (callable func)
    {"module" (. (. inspect (getmodule func) __name__))
     "filename" (. inspect (getfile func))
     "lineno" func.__code__.co_firstlineno}))

(defmacro deftest [func-name #* body]
  `(defn ~(hy.models.Symbol f"test-{func-name}") []
     (import hyrule [flatten])
     {"test" f"{'~func-name}"
      "info" (try
               (get-func-info ~func-name)
               (except [[NameError TypeError]]
                 {"module" None "filename" None "lineno" None}))
      "results" (do (flatten [~@body]))}))

(defmacro defsuite [suite-name #* description-tests-pairs]
   `(defn ~(hy.models.Symbol f"test-suite-{suite-name}") []
      (require hyrule [fn+])
      (import toolz [partition])
      (list
        (map (fn+ [[description tests]]
               {"description" description "suite" tests})
             (partition 2 ~description-tests-pairs)))))

(defn run-test-suites [package-name #* suites]
  {"package" package-name
   "start_datetime" (-> datetime (.now) (.strftime "%Y-%m-%d %H:%M:%S.%f"))
   "runs" (list (concatv #* suites))
   "finish_datetime" (-> datetime (.now) (.strftime "%Y-%m-%d %H:%M:%S.%f"))})
