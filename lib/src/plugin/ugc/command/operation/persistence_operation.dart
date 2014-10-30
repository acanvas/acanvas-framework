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
part of stagexl_rockdot;

class PersistenceOperation extends AbstractOperation {
	 Logger log = new Logger("PersistenceOperation");

	 PersistenceOperation(dynamic service,String methodName, [Map dto = null]) {
	   
	   String params = null;
	   if(dto != null){
	     params = JSON.encode(dto);
	   }
	   
	   methodName = methodName.replaceAll(new RegExp(r'UGCEndpoint.'), '');
	   String url = RockdotConstants.getContext().propertiesProvider.getProperty("project.host.json");
	   ServerProxy proxy = new ServerProxy(url);
     proxy.call(methodName, params)
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

