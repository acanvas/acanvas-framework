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
part of stagexl_rockdot.facebook;


/**
 * <code>IObjectPostProcessor</code> implementation that checks for objects that implement the <code>IApplicationContextAware</code>
 * abstract class and injects them with the provided <code>IApplicationContext</code> instance.
 * <p>
 * <b>Author:</b> Christophe Herreman<br/>
 * <b>Version:</b> $Revision: 21 $, $Date: 2008-11-01 22:58:42 +0100 (za, 01 nov 2008) $, $Author: dmurat $<br/>
 * <b>Since:</b> 0.1
 * </p>
 * @inheritDoc
 */
class FBModelInjector implements IObjectPostProcessor {
  IObjectFactory _applicationContext;

  FBModelInjector(IObjectFactory applicationContext) {
    _applicationContext = applicationContext;
  }


  /**
   * @inheritDoc
   */
  dynamic postProcessAfterInitialization(dynamic object, String objectName) {
    if (object is IFBModelAware) {
      object.fbModel = _applicationContext.getObject(FacebookPlugin.MODEL_FB);
    }

    return object;
  }

  dynamic postProcessBeforeInitialization(dynamic object, String objectName) {
    return object;
  }
}

