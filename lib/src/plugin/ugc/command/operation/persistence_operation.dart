/*
 * Copyright 2007-2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of rockdot_dart;

class PersistenceOperation extends AbstractOperation {
	 RockdotLogger log = new RockdotLogger("PersistenceOperation");

	 PersistenceOperation(dynamic service,String methodName, [List args = null]) {
	   
//	   String url = _context.propertiesProvider.getProperty("project.host.json");
	   methodName = methodName.replaceAll(new RegExp(r'UGCEndpoint.'), '');
	   
	   
	   String url = RockdotConstants.getContext().propertiesProvider.getProperty("project.host.json");
	   ServerProxy proxy = new ServerProxy(url);
     proxy.call(methodName,[JSON.encode(args[0].toMap())])
          .then((returned)=>proxy.checkError(returned))
          .then((result){
           // print(result.toString());
            dispatchCompleteEvent(result);
       });
	   /*
                  })
          .catchError((error){
       print(error);
       */
		}
	}

