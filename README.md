# digit_image_identification_using_keras

this is a project on recognize handwritten digits using keras.
with MNIST dataset

The MNIST dataset is included with Keras and can be accessed using the dataset_mnist() function. 
he x data is a 3-d array (images,width,height) of grayscale values .

The core data structure of Keras is a model, a way to organize layers. The simplest type of model is the Sequential model, a linear stack of layers.

The input_shape argument to the first layer specifies the shape of the input data (a length 784 numeric vector representing a grayscale image). The final layer outputs a length 10 numeric vector (probabilities for each digit) 

the neural network consists of three dense layers with
 first layer having a relu activation function with 256 units 
 second layer having a relu activation function with 128 units
 third(output) layer having a softmax activation function with 10 units 

