install.packages("keras")

#The Keras R interface uses the TensorFlow backend engine by default. 
#To install both the core Keras library as well as the TensorFlow backend use the install_keras() function:
library(keras)
install_keras()

mnist<- dataset_mnist()

x_train<- mnist$train$x
y_train<- mnist$train$y
x_test<- mnist$test$x
y_test<- mnist$test$y

#The x data is a 3-d array (images,width,height) of grayscale values . To prepare the data for training we convert
#the 3-d arrays into matrices by reshaping width and height into a single dimension (28x28 images are flattened into 
#length 784 vectors). Then, we convert the grayscale values from integers ranging between 0 to 255 into floating point 
#values ranging between 0 and 1:

#reshaping 
x_train<- array_reshape(x_train,c(nrow(x_train),784))
x_test<- array_reshape(x_test,c(nrow(x_test),784))

#rescaling 
x_train<- x_train/255
x_test<- x_test/255

#The y data is an integer vector with values ranging from 0 to 9. To prepare this data for training we one-hot encode 
#the vectors into binary class matrices using the Keras to_categorical() function:

y_train<- to_categorical(y_train,10)
y_test<- to_categorical(y_test,10)

model <- keras_model_sequential() 

model%>%
  layer_dense(units=256,activation = 'relu',input_shape = c(784))%>%
  layer_dropout(rate = 0.4)%>%
  layer_dense(units = 128,activation = 'relu')%>%
  layer_dropout(rate = 0.3)%>%
  layer_dense(units = 10,activation = 'softmax')

summary(model)

#compile the model 
model%>%compile(loss='categorical_crossentropy',
                optimizer = optimizer_rmsprop(),
                metrics=c('accuracy')
                )

#Use the fit() function to train the model for 30 epochs using batches of 128 images:
history<-model%>%fit(
  x_train,y_train,epochs=30,batch_size=128,
  validation_split=0.2
  )

#plot the accuracy loss for each epoch 
plot(history)

#evaluating the model
model %>% evaluate(x_test, y_test)

#predicting the model 
model %>% predict_classes(x_test)


